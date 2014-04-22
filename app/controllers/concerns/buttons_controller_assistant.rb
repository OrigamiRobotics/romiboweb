module ButtonsControllerAssistant
  extend ActiveSupport::Concern

  def set_session_values(params, session)
    if params[:status] == 'new' ||
        (session[:last_action] == 'new' && params[:status] == 'duplicate')
      session[:adding_button] = true
      session[:last_action]   = 'new'
    else
      session[:adding_button] = false
      session[:last_action] = 'not_new'
    end
  end

  def get_palette(params, session)
    session[:adding_button] = false

    @button  = Button.find(params[:id]) if params[:id].present?
    @palette = (@button.present? && @button.palette_id.present?) ?
                                    @button.palette :
                                    Palette.find(params[:palette_id])
  end

  def ok_to_add?(params, session)
    (params[:status].present? && params[:status] == 'new') ||
        (params[:status].present? && params[:status] == 'copy')   ||
        (params[:keypress].present? &&
            params[:status].present? &&
            params[:status] == 'duplicate' &&
            session[:adding_button] == true)
  end

  def json_create(params, palette)
    button =  palette.buttons.build(button_params(params)) if palette.present?
    if button.save
      button
    else
      button.errors.full_messages
    end
  end

  def button_params(params)
    unless params[:status].present?
      params[:button][:speech_phrase] = params[:button][:title]  \
        if params[:button][:speech_phrase] == 'Hello' &&
           params[:button][:title] != 'Untitled Button'
    end
    params.require(:button).permit(:title, :speech_phrase,
                                   :speech_speed_rate, :user_id,
                                   :button_color_id, :size)
  end

  def clone_button_params(params)
    params.require(:button).permit(:title, :speech_phrase,
                                   :speech_speed_rate, :user_id,
                                   :button_color_id, :size)
  end

  def check_for_palette_id(params)
    unless params[:palette_id].present?
      raise "Missing palette id"
    end
  end

end
