class ButtonsController < ApplicationController

  include ButtonsControllerAssistant
  include CommonButtonsPalettesMethods

  before_action :get_correct_palette, :set_session

  def new
    begin
      @button = Button.new Button.default_values(current_user)
    rescue ActiveRecord::RecordNotFound => ex
      handle_error "#{ex.message}"
    end
  end

  def create
    if params[:js].present?
      if ok_to_add?(params, session)
        @button = Button.js_create(params, @palette, session, current_user)
      end
    else
      @button = json_create(params, @palette)
      handle_error(@button) unless  @button.is_a?Button
    end
  end

  # POST /palettes/:palette_id/buttons/:id/clone
  def clone
    button_to_clone = Button.find params[:id]
    @palette = Palette.find params[:palette_id]
    head :not_found and return unless button_to_clone
    @button = button_to_clone.dup
    @palette.buttons << @button
    @button.save
  end

  def show
    @button = Button.find(params[:id])
    @button.set_selection params
    set_palette_buttons_values @button.speech_speed_rate, @button.button_color_id, @button.size, session
    @button.update_parent_palette
  end

  def update
    @button = Button.find(params[:id]) if params[:id].present?
    @button.update_parent_palette
    if params[:status].present?
      clone_button if params[:status] == 'clone'
    else
      unless @button.update_attributes(button_params(params))
      end
    end
  end

  def destroy
    button = Button.find(params[:id])
    button.destroy
    @button = @palette.buttons.first if @palette.buttons.present?
    @button.update_parent_palette if @button.present?
    respond_to do |format|
      format.html {redirect_to palettes_path}
      format.js
    end
  end

  private

  def handle_error(msg)
    render(json: { error: msg}.to_json, status: 404) && return
  end

  def get_correct_palette
    begin
      get_palette(params, session)
    rescue => ex
      handle_error ex.message
    end
  end

  def set_session
    set_session_values(params, session)
  end
end
