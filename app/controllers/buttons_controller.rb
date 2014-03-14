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
      if ok_to_add?
        session[:adding_button] = true unless params[:option] == 'clone'
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
    if params[:status].present?
      session[:adding_button] = false if params[:status] == 'done'
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

  private
  def update_parent_palette
    if @palette.present?
      @palette.last_viewed_button = @button.id
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
    puts "got here!!!!!!!!!"
    if params[:option] == 'clone'
      @button = @palette.buttons.build(clone_button_params)
    else
      puts "moved hereeeeee"
      @button = @palette.buttons.build(default_values)
    end
    @button.save
    puts @button.to_yaml
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
      button_color_id:   ButtonColor.find_by_name('Orange').id,
      size:              'Medium',
      user_id:           current_user.id
    }
  end

  def ok_to_add?
    (params[:status].present? && params[:status] == 'new') ||
    (params[:js].present? && params[:option] == 'clone') ||
    (params[:keypress].present? && session[:adding_button] == true)
  end

end
