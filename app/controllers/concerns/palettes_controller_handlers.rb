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
    check_speed_rate
    check_color_value
    check_size_value
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
  def get_speech_sped_rate
    params[:palette][:speech_speed_rate].to_f
  end

  def get_button_color
    params[:palette][:button_color].to_i
  end

  def get_size
    params[:palette][:size]
  end

  def palettes_buttons
    set_palette_buttons_values(get_speech_sped_rate,
                               get_button_color,
                               get_size
    ) if params[:selection].present? && params[:selection] == 'updating'
  end

  def check_speed_rate
    if params[:change_speed_rate].present? && params[:change_speed_rate] == 'yes'
      @palette.selected_buttons.update_all(speech_speed_rate: params[:palette][:speech_speed_rate].to_f)
    end
  end

  def check_color_value
    if params[:change_color_value].present? && params[:change_color_value] == 'yes'
      @palette.selected_buttons.update_all(button_color_id: params[:palette][:button_color].to_i)
    end
  end

  def check_size_value
    if params[:change_size_value].present? && params[:change_size_value] == 'yes'
      @palette.selected_buttons.update_all(size: params[:palette][:size])
    end
  end
end
