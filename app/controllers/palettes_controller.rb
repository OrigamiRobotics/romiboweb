class PalettesController < ApplicationController
  before_filter :authenticate_user!
  def new
  end

  def create
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

  private

  def palette_params
    params.require(:palette).permit(:title, :description, :color)
  end

end
