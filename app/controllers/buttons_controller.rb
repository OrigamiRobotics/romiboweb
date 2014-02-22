class ButtonsController < ApplicationController
  def new
    @button = Button.new
  end

  def create
    check_for_palette_id
    begin
      @palette = Palette.find(params[:palette_id])
    rescue ActiveRecord::RecordNotFound => ex
      render(json: {error: "#{ex.message}"}.to_json, status: 404) and return
    end
    do_create
  end

  private
  def do_create
    @button =  @palette.buttons.build(button_params)
    unless @button.save
      puts @button.inspect
      render(json: { error: @button.errors.full_messages}, status: 404) and return
    end
  end

  def check_for_palette_id
    unless params[:palette_id].present?
      render(json: {error: "Missing palette id"}.to_json, status: 404) and return
    end
  end

  def button_params
    params.require(:button).permit(:title, :color, :speech_phrase, :speech_speed_rate, :user_id)
  end
end
