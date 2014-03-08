class Palettes::ShareController < ApplicationController
  def new
    @palette = Palette.find params[:palette_id]
  end

  def create
  end
end
