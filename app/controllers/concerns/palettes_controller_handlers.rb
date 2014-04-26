module PalettesControllerHandlers
  extend ActiveSupport::Concern

  def handle_after_create_and_save
    @palette.add_default_button(@user)
    @user.set_last_viewed_palette @palette
    @palettes = @user.palettes
  end

  def handle_format_after_update(format)
    format.html {redirect_to palettes_path, format: :js}
    format.js
    format.json { render json: @palette }
  end


  def handle_selections
    select = params[:selection]
    applicable_method.fetch(select.to_sym).call

  end

  def handle_multiple_edits
    check_value(:change_speed_rate, :speech_speed_rate, :speech_speed_rate).to_f
    check_value(:change_color_value, :button_color_id, :button_color).to_i
    check_value :change_size_value, :size, :size
  end

  def handle_singular_selections
    button = Button.find(params[:button_id])
    if params[:checked] == 'true'
      button.update_attributes(selected: true)
    else
      button.update_attributes(selected: false)
    end
    update_all_buttons_selected
  end

  private
  def get_speech_rate_or_button(value)
    params[:palette][value]
  end

  def get_size
    params[:palette][:size]
  end

  def palettes_buttons
    set_palette_buttons_values(get_speech_rate_or_button(:speech_speed_rate).to_f,
                               get_speech_rate_or_button(:button_color).to_i,
                               get_size
    ) if params[:selection].present? && params[:selection] == 'updating'
  end

  # def check_speed_rate
  #   check_value(:change_speed_rate, :speech_speed_rate, :speech_speed_rate).to_f
  # end
  #
  # def check_color_value
  #   check_value(:change_color_value, :button_color_id, :button_color).to_i
  # end
  #
  # def check_size_value
  #   check_value :change_size_value, :size, :size
  # end

  def check_value(param1, param2, param3)
    if params[param1].present? && params[param1] == 'yes'
      @palette.selected_buttons.update_all(param2 => params[:palette][param3])
    end
  end
end
