module ButtonCreator
  extend ActiveSupport::Concern

  def js_create(params, palette, session, user)
    if params[:status] == 'copy'
      button = palette.buttons.build(clone_button_params(params))
    else
      button = palette.buttons.build(default_values(user))
      session[:last_action] = 'new'
    end
    button.save
    button.update_parent_palette
    button
  end

  def default_values(user)
    {
        title:             'Untitled Button',
        speech_phrase:     'Hello',
        speech_speed_rate: 0.2,
        button_color_id:   ButtonColor.find_by_name('Turquoise').id,
        size:              'Large',
        user_id:           user.id
    }
  end

  def clone_button_params(params)
    params.require(:button).permit(:title, :speech_phrase,
                                   :speech_speed_rate, :user_id,
                                   :button_color_id, :size)
  end

end
