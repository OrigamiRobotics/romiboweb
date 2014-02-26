class Api::V1::PalettesController < ApplicationController
  respond_to :json

  def index
    @palettes = Palette.all
  end

end
