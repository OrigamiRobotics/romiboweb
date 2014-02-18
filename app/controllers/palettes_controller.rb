class PalettesController < ApplicationController
  def new
  end

  def create
  end

  def edit
    @palette = Palette.find params[:id]
  end
end
