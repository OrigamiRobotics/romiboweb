# RESTful API for Buttons.
#

class Api::V1::ButtonsController < Api::BaseController

  # A generic index implementation, intended primarily to be
  # used to retrieve all Button Colors for current User.
  #
  # * *Args*    :
  #   - none
  # * *Returns* :
  #   - all buttons
  # * *Raises* :
  #   - +ArgumentError+ -> if any value is nil or negative
  #
  def colors
    @button_colors = ButtonColor.all
  end

end
