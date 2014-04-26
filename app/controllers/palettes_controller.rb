class PalettesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :palette_owner, only: :destroy
  before_filter :set_gon, :set_session
  before_filter :set_user

  include CommonButtonsPalettesMethods
  include PalettesControllerAssistant
  include PalettesControllerHandlers
  include PalettesControllerUpdaters
  include PalettesControllerFormatters


  def new
    @palette = Palette.new
    respond_to do |format|
      format.html {redirect_to palettes_path}
      format.js
    end
  end

  def create
    @palette =  @user.palettes.build(palette_params)
    respond_to do |format|
      if @palette.save
        handle_after_create_and_save
        respond_to_format_for format
      else
        format.html {redirect_to palettes_path}
      end
    end
  end

  def edit
    @palette = Palette.find params[:id]
    @user.set_last_viewed_palette @palette
    respond_to do |format|
      format.js
    end
  end

  def update
    @palette = Palette.find params[:id]
    @palettes = @user.palettes
    respond_to do |format|
      if update_applicable_palette
        handle_format_after_update format
      else
        handle_format_for_invalid_input format
      end
    end
  end

  def index
    set_params
    @palettes = @user.palettes
    respond_to do |format|
      format.html
      format.json {render json: @palettes}
      format.js
    end
  end

  def show
    @palette = Palette.find params[:id] if params[:id].present?
    @button  = @palette.current_button
    @user.set_last_viewed_palette @palette
    if params[:shared].present? && params[:shared] == 'true'
      session[:viewing_another_palette] = false
    else
      session[:viewing_another_palette] = true
    end
    respond_to_format_for_show
  end

  def destroy
    (params[:mode].present? && params[:mode] == 'multiple') ? delete_buttons : @palette.destroy
    respond_to do |format|
      @palettes = @user.palettes
      format.html {redirect_to palettes_path}
      format.js
    end
  end

  def import
    content = clean_file_content(params[:palette]["file"].read.to_s)
    begin
      @palette = Palette.from_file(@user, content)
    rescue => ex
      flash[:alert] = ex.message
    end
    flash[:success] = "The file #{params[:palette][:file].original_filename} was successfully " +
        "imported and a new palette (#{@palette.title}) was created with it!"
    redirect_to palette_path(@palette), format: 'js'
  end

  def copy_buttons
    source_palette = Palette.find params[:id] if params[:id].present?
    target_id = params[:target_id].gsub(/palette_link_/, '').to_i
    @palette = Palette.find(target_id)
    flash[:notice] = "#{source_palette.number_of_selected_buttons} buttons successfully added to palette (#{source_palette.title})"
    @palette.add_buttons(source_palette.selected_buttons.map{|button| button.hash_params})
  end

  def save_grid
    @palette = Palette.find params[:id]
    button_data = ActiveSupport::JSON.decode params[:button_data]
    button_data.each do |data|
      button = Button.find data['id']
      button.update_attributes(row: data['row'], col: data['col'])
    end
    head :ok and return
  end

  private

  def palette_params
    params.require(:palette).permit(:title, :description, :color)
  end

  def clean_file_content(content)
    content.gsub(/=\r\n/, '')
  end
end
