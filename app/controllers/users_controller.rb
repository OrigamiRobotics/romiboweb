class UsersController < ApplicationController
  before_filter :authenticate_user!, unless: { }
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
