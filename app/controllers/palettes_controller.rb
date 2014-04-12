class PalettesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :palette_owner, only: :destroy
  before_filter :set_gon, :set_session
  before_filter :set_user

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
        @user.set_last_viewed_palette @palette
        @palettes = @user.palettes
        respond_to_format_for_create format
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
        format.html {redirect_to palettes_path}
        format.js
        format.json { respond_with_bip(@palette) }
      else
        flash[:alert] = 'Invalid Input'
        format.html {redirect_to palettes_path}
        format.js
        format.json { respond_with_bip(@palette) }
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
    if @palette
      respond_to do |format|
        format.html {redirect_to palettes_path}
        format.js #show.js.erb
      end
    end

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

  private

  def delete_buttons
    @user.set_last_viewed_palette @palette
    @palette.update_attributes(last_viewed_button: nil)
    #@palette.selected_buttons.each do |button|
    #  Button.delete(button.id)
    #  puts "deleted #{button.id}"
    #end
    @palette.delete_buttons
    @button = @palette.current_button
  end

  def respond_to_format_for_create(format)
    format.html {redirect_to palettes_path}
    format.json { render json: @palette }
    format.js
  end

  def update_applicable_palette
    if params[:mode].present? &&
       params[:mode] == "multiple"
      handle_selections
    else
      @palette.update_attributes(palette_params)
    end
  end

  def handle_selections
    select = params[:selection]
    applicable_method.fetch(select.to_sym).call
    set_palette_buttons_values(params[:palette][:speech_speed_rate].to_f,
                               params[:palette][:button_color].to_i,
                               params[:palette][:size]
    ) if params[:selection].present? && params[:selection] == 'updating'
  end

  def applicable_method
    {:all      => method(:select_all_buttons),
    :none      => method(:deselect_all_buttons),
    :updating  => method(:handle_multiple_edits),
    :singular  => method(:handle_singular_selections)
    }
  end

  def handle_multiple_edits
    if params[:change_speed_rate].present? && params[:change_speed_rate] == 'yes'
      @palette.selected_buttons.update_all(speech_speed_rate: params[:palette][:speech_speed_rate].to_f)
    end

    if params[:change_color_value].present? && params[:change_color_value] == 'yes'
      @palette.selected_buttons.update_all(button_color_id: params[:palette][:button_color].to_i)
    end

    if params[:change_size_value].present? && params[:change_size_value] == 'yes'
      @palette.selected_buttons.update_all(size: params[:palette][:size])
    end
  end

  def handle_singular_selections
    button = Button.find(params[:button_id])
    if params[:checked] == 'true'
      button.update_attributes(selected: true)
    else
      button.update_attributes(selected: false)
    end
    update_all_buttons_selected
  end

  def update_all_buttons_selected
    (@palette.just_selected_all_buttons?) ?
        @palette.update_attributes(all_buttons_selected: true) :
        @palette.update_attributes(all_buttons_selected: false)
  end

  def select_all_buttons
    set_all_buttons_selected true
  end

  def deselect_all_buttons
    set_all_buttons_selected false
  end

  def set_all_buttons_selected(make_selected)
    @palette.update_attributes(all_buttons_selected: make_selected)
    @palette.buttons.update_all({selected: make_selected})
  end

  def set_params
    @title = 'Palette Editor'
    @palette = Palette.new
    @palettes = @user.palettes
    if @palettes.present?
      @current_palette = @user.current_palette
      gon.active_palette = @current_palette.id
    end
  end

  def palette_params
    params.require(:palette).permit(:title, :description, :color)
  end

  def palette_owner
    @palette = @user.palettes.find_by_id(params[:id])
    redirect_to(palettes_path) if @palette.nil?
  end

  def clean_file_content(content)
    content.gsub(/=\r\n/, '')
  end

  def set_user
    if params[:palette_user_id].present? || session[:palette_user_id].present?
      user_id = (params[:palette_user_id].present?) ? params[:palette_user_id].to_i : session[:palette_user_id].to_i
      @user = User.find(user_id)
      session[:palette_user_id] = params[:palette_user_id]
    else
      @user = current_user
      session[:palette_user_id] = nil
    end
  end
end
