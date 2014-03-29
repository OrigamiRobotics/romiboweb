# RESTful API for Palette.
#

class Api::V1::PalettesController < Api::BaseController

  # A generic index implementation, intended primarily to be
  # used to retrieve all Palettes for current User.
  #
  # * *Args*    :
  #   - none
  # * *Returns* :
  #   - the palettes belonging to current user
  # * *Raises* :
  #   - +ArgumentError+ -> if any value is nil or negative
  #
  def index
    @palettes = @current_user.palettes
  end

end
