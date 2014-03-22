class UsersController < ApplicationController
  before_filter :authenticate_user!, unless: { action: 'locale' }
  before_filter :set_gon


  #def new
  #  @user = User.new
  #end
  #
  #
  #def create
  #  @user = User.new(user_params)
  #
  #  respond_to do |format|
  #    if @user.save
  #      format.html {redirect_to root_path}
  #    else
  #      render :new
  #    end
  #  end
  #end

  def dashboard
    @title = "Dashboard"
    @user = current_user
  end

  def locale
    chosen_locale = params[:user_locale]
    if I18n.locale_available? chosen_locale
      cookies.delete :user_locale
      cookies[:user_locale] = {
        value: chosen_locale,
        expires_in: 2.weeks.from_now
      }
    end
    redirect_to request.env['HTTP_REFERER'] || root_path
  end

  def unconfirmed
    @title = "Unconfirmed Registration"
    handle_params
    respond_to do |format|
      format.html
    end
  end

  def confirmed
    @title = "New User Sign in"
    puts "###### " + params.to_yaml
  end

  private

  def handle_params
    @user = User.find(params[:index])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
