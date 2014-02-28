class ButtonsController < ApplicationController
  before_filter :get_palette
  def new
    begin
      @button = Button.new default_values
    rescue ActiveRecord::RecordNotFound => ex
      handle_error "#{ex.message}"
    end
  end

  def create
    if params[:js].present?
      js_create
    else
      json_create
    end
  end


  def show
    @button = Button.find(params[:id])
  end


  private
  def json_create
    begin
      do_create
    rescue ActiveRecord::RecordNotFound => ex
      handle_error "#{ex.message}"
    end
  end

  def js_create
    @button = @palette.buttons.build(default_values)
    @button.save
    puts @palette.buttons.count.to_s
  end

  def do_create
    @button =  @palette.buttons.build(button_params) if @palette
    unless @button.save
      handle_error @button.errors.full_messages
    end
  end

  def check_for_palette_id
    unless params[:palette_id].present?
      handle_error "Missing palette id"
    end
  end

  def button_params
    params.require(:button).permit(:title, :color, :speech_phrase,
                                   :speech_speed_rate, :user_id,
                                   :button_color_id, :size)
  end

  def handle_error(msg)
    render(json: { error: msg}.to_json, status: 404) && return
  end

  def get_palette
    begin
      @palette = Palette.find(params[:palette_id])
    rescue => ex
      handle_error ex.message
    end
  end

  def default_values
    {
      title:             'Untitled Button',
      speech_phrase:     'Hello',
      speech_speed_rate: 2,
      button_color_id:   ButtonColor.find_by_name('ORANGE').id,
      size:              'Medium',
      user_id:           current_user.id
    }
  end
end
