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
    palette_hash = palette_params
    @palette = Palette.find_by_id_and_owner_id(palette_hash[:id], @current_user.id)

    if @palette.nil?
      palette_hash.delete :id
      @palette = @current_user.palettes.build(palette_hash)
      @palette.save
      if params[:palette][:buttons]
        params[:palette][:buttons].each do |button_hash|
          button_hash = build_button_hash(button_hash)
          build_button(button_hash)
        end
      end
      if @palette.save
        respond_with @palette, status: :created
      else
        @palette.delete if @palette.id # destroy the palette if it was created for safer retry
        render json: @palette.errors, status: :unprocessable_entity
      end
    else
      @palette.update_attributes(palette_hash)
      if params[:palette][:buttons]
        params[:palette][:buttons].each do |button_hash|
          button_hash = build_button_hash(button_hash)


          @button = Button.find_by_id_and_palette_id(button_hash[:id],button_hash[:palette_id])
          if(@button.nil?)
            build_button(button_hash)
          else
            @button.update(title: button_hash[:title], speech_phrase: button_hash[:speech_phrase],
                                    speech_speed_rate: button_hash[:speech_speed_rate],
                                    user_id: button_hash[:user_id],
                                    button_color_id:   button_hash[:button_color_id],
                                    size:              'Large'
            )
          end


        end
      end
      if @palette.save
        respond_with @palette, status: :created
      else
        @palette.delete if @palette.id # destroy the palette if it was created for safer retry
        render json: @palette.errors, status: :unprocessable_entity
      end
    end



  end

  def build_button(button_hash)
    @palette.buttons.build(title: button_hash[:title], speech_phrase: button_hash[:speech_phrase],
                           speech_speed_rate: button_hash[:speech_speed_rate],
                           user_id: button_hash[:user_id],
                           button_color_id: button_hash[:button_color_id],
                           size: 'Large'
    )
  end

  def build_button_hash(button_hash)
    button_color_id = ButtonColor.find_by_value(button_hash[:color]).try(:id) || ButtonColor.default.id
    button_hash = button_hash.merge button_color_id: button_color_id
    button_hash = button_hash.merge size: 'Large' unless button_hash[:size]
    button_hash = button_hash.merge user_id: @current_user.id
    button_hash.delete :color
    button_hash
  end

  private
  def palette_params
    params.require(:palette).permit(
        :title,
        :id,
        :description,
        :color,
        button: [
            :id,
            :palette_id,
            :title,
            :speech_phrase,
            :speech_speed_rate,
            :user_id,
            :button_color_id,
            :size
        ]
    )
  end

end
