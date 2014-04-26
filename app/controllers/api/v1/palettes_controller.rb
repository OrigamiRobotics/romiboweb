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
    @palettes = @current_user.palettes.includes :buttons
  end
  
  def create
    head :unprocessable_entity and return unless params[:palette]
    @palette = @current_user.palettes.build(palette_params)
    @palette.save
    # @palette.add_default_button(@current_user)
    if params[:palette][:buttons]
      params[:palette][:buttons].each do |button_hash|
        button_color_id = ButtonColor.find_by_value(button_hash[:color]).try(:id) || ButtonColor.default.id
        button_hash = button_hash.merge button_color_id: button_color_id
        button_hash = button_hash.merge size: 'Medium' unless button_hash[:size]
        button_hash = button_hash.merge user_id: @current_user.id
        button_hash.delete :color
        @palette.buttons.build button_hash
      end
    end
    respond_with @palette, status: :created if @palette.save
    render json: @palette.errors, status: :unprocessable_entity unless @palette.save
  end

  private
  def palette_params
    params.require(:palette).permit(
        :title, 
        :description, 
        :color,
        button: [
            :title,
            :speech_speed_rate,
            :color,
            :button_color_id,
            :size
        ]
    )
  end

end
