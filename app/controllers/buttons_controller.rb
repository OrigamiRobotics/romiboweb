class ButtonsController < ApplicationController
  before_filter :get_palette, :set_session
  def new
    begin
      @button = Button.new default_values
    rescue ActiveRecord::RecordNotFound => ex
      handle_error "#{ex.message}"
    end
  end

  def create
    if params[:js].present?
      if ok_to_add?
        js_create
      end
    else
      json_create
    end
  end


  def show
    @button = Button.find(params[:id])
    update_parent_palette
  end

  def update
    @button = Button.find(params[:id]) if params[:id].present?
    update_parent_palette
    if params[:status].present?
      #session[:adding_button] = false if params[:status] == 'done'
      clone_button if params[:status] == 'clone'
    else
      unless @button.update_attributes(button_params)
      end
    end
  end

  def destroy
    button = Button.find(params[:id])
    button.destroy
    @button = @palette.buttons.first if @palette.buttons.present?
    update_parent_palette
    respond_to do |format|
      format.html {redirect_to palettes_path}
      format.js
    end

  end

  def grid
    @palette = Palette.find params[:palette_id]
    respond_to do |format|
      format.html {redirect_to palettes_path}
      format.js
    end
  end

  def save_grid
    @palette = Palette.find params[:palette_id]
    button_data = ActiveSupport::JSON.decode params[:button_data]
    button_data.each do |data|
      button = Button.find data['id']
      button.row = data['row']
      button.col = data['col']
      button.save
    end
    respond_to do |format|
      format.html {redirect_to palettes_path}
      format.js
    end
  end

  private
  def update_parent_palette
    if @palette.present?
      @palette.last_viewed_button = @button.id if @button.present?
      @palette.save
    end
  end


  def json_create
    begin
      do_create
    rescue ActiveRecord::RecordNotFound => ex
      handle_error "#{ex.message}"
    end
  end

  def js_create
    if params[:status] == 'copy'
      @button = @palette.buttons.build(clone_button_params)
    else
      @button = @palette.buttons.build(default_values)
      session[:last_action] = 'new'
    end
    @button.save
    update_parent_palette
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
    unless params[:status].present?
      params[:button][:speech_phrase] = params[:button][:title]  \
        if params[:button][:speech_phrase] == 'Hello' &&
           params[:button][:title] != 'Untitled Button'
      params.require(:button).permit(:title, :speech_phrase,
                                     :speech_speed_rate, :user_id,
                                     :button_color_id, :size)
    end
  end

  def clone_button_params
    params.require(:button).permit(:title, :speech_phrase,
                                   :speech_speed_rate, :user_id,
                                   :button_color_id, :size)
  end

  def handle_error(msg)
    render(json: { error: msg}.to_json, status: 404) && return
  end

  def get_palette
    session[:adding_button] = false
    begin
      @palette = Palette.find(params[:palette_id])
      update_parent_palette
    rescue => ex
      handle_error ex.message
    end
  end

  def default_values
    {
      title:             'Untitled Button',
      speech_phrase:     'Hello',
      speech_speed_rate: 0.2,
      button_color_id:   ButtonColor.find_by_name('Turquoise').id,
      size:              'Medium',
      user_id:           current_user.id
    }
  end

  def ok_to_add?
    (params[:status].present? && params[:status] == 'new') ||
    (params[:status].present? && params[:status] == 'copy')   ||
    (params[:keypress].present? &&
     params[:status].present? &&
     params[:status] == 'duplicate' &&
     session[:adding_button] == true)
  end


  def set_session
    if params[:status] == 'new' ||
      (session['last_action'] == 'new' and params[:status] == 'duplicate')
      session[:adding_button] = true
      session[:last_action] = 'new'
    else
      session[:adding_button] = false
      session[:last_action] = 'not_new'
    end
  end
end
