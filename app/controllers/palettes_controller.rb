class PalettesController < ApplicationController
  #respond_to :html, :json, :js
  before_filter :authenticate_user!
  def new
    @palette = Palette.new
  end

  def create
    @palette =  current_user.palettes.build(palette_params)
    respond_to do |format|
      if @palette.save
        format.html {redirect_to romiboweb_pages_editor_path}
        format.json { render json: @palette }
        format.js #palettes/create.js.erb
      else
        format.html {redirect_to romiboweb_pages_editor_path}
      end

    end
  end

  def edit
    @palette = Palette.find params[:id]
  end

  def update
    @palette = Palette.find params[:id]
    if @palette.update_attributes(palette_params)
      render 'index'
    else
      flash[:alert] = 'Invalid Input'
      redirect_to edit_palette_path @palette
    end
  end

  def index
    @title = 'Palette Editor'
    @palette = Palette.new
    @palettes = Palette.where("owner_id = :id", { id: current_user.id })
    respond_to do |format|
      format.html
      format.json {render json: @palettes}
    end
    #respond_with @palettes
  end

  private

  def palette_params
    params.require(:palette).permit(:title, :description, :color)
  end

end
