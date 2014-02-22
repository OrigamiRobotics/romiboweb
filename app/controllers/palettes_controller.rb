class PalettesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!
  def new
  end

  def create
    @palette =  current_user.palettes.build(palette_params)
    @palette.save
    puts @palette.inspect
    @palette
    respond_to do |format|

      format.json { render json: @palette }
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
    @palettes = Palette.where("owner_id = :id", { id: current_user.id })
    respond_with @palettes
  end

  private

  def palette_params
    params.require(:palette).permit(:title, :description, :color)
  end

end
