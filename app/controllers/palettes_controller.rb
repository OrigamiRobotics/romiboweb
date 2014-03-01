class PalettesController < ApplicationController
  #respond_to :html, :json, :js
  before_filter :authenticate_user!, :set_gon
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
    respond_to do |format|
      format.js
    end
  end

  def update
    @palette = Palette.find params[:id]
    respond_to do |format|
      if @palette.update_attributes(palette_params)
        @palettes = current_user.palettes
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
    end
    #respond_with @palettes
  end

  def show
    @palette = Palette.find params[:id]
    @button  = @palette.buttons.order(:id).first if @palette.buttons.present?

    if @palette
      respond_to do |format|
        format.html {redirect_to palettes_path}
        format.js #show.js.erb
      end
    end

  end

  private
  def set_params
    @title = 'Palette Editor'
    @palette = Palette.new
    @palettes = current_user.palettes
    if @palettes.present?
      @first_palette = @palettes.first
      gon.first_palette = @first_palette.id
    end
  end

  def palette_params
    params.require(:palette).permit(:title, :description, :color)
  end

end
