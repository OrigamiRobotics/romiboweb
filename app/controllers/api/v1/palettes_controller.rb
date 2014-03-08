class Api::V1::PalettesController < Api::BaseController

  def index
    @palettes = @current_user.palettes
  end

end
