class PalettesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :palette_owner,     only: :destroy
  before_filter :set_gon

  def new
    @palette = Palette.new
    respond_to do |format|
      format.html {redirect_to palettes_path}
      format.js
    end
  end

  def create
    @palette =  current_user.palettes.build(palette_params)
    respond_to do |format|
      if @palette.save
        @palettes = current_user.palettes
        format.html {redirect_to palettes_path}
        format.json { render json: @palette }
        format.js
      else
        format.html {redirect_to palettes_path}
      end

    end
  end

  def edit
    @palette = Palette.find params[:id]
    current_user.set_last_viewed_palette @palette
    puts "edit ----- " + current_user.current_palette.inspect

    respond_to do |format|
      format.js
    end
  end

  def update
    @palette = Palette.find params[:id]
    respond_to do |format|
      if @palette.update_attributes(palette_params)
        @palettes = current_user.my_palettes
        format.html {redirect_to palettes_path}
        format.js
      else
        flash[:alert] = 'Invalid Input'
        format.html {redirect_to palettes_path}
        format.js
      end
    end
  end

  def index
    set_params
    respond_to do |format|
      format.html
      format.json {render json: @palettes}
      format.js
    end
  end

  def show
    @palette = Palette.find params[:id] if params[:id].present?
    @button  = @palette.current_button
    current_user.set_last_viewed_palette @palette
    puts "show ----- " + current_user.current_palette.inspect
    if @palette
      respond_to do |format|
        format.html {redirect_to palettes_path}
        format.js #show.js.erb
      end
    end

  end

  def destroy
    @palette.destroy
    respond_to do |format|
      @palettes = current_user.palettes
      format.html {redirect_to palettes_path}
      format.js
    end
  end

  private
  def set_params
    @title = 'Palette Editor'
    @palette = Palette.new
    @palettes = current_user.my_palettes

    if @palettes.present?
      @current_palette = current_user.current_palette
      puts "%%%% "+ @current_palette.inspect
      gon.first_palette = @current_palette.id
    end
  end

  def palette_params
    params.require(:palette).permit(:title, :description, :color)
  end

  def palette_owner
    @palette = current_user.palettes.find_by_id(params[:id])
    redirect_to(palettes_path) if @palette.nil?
  end
end
