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
    @user.create_profile
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

  def role
    user = User.find(params[:role_user_id]) if params[:role_user_id].present?
    user.admin = (params[:new_user_role] == 'true') ? true : false
    user.save
    message = "#{user.full_name} has been successfully"
    flash[:notice] = message + ((user.admin?) ? " assigned admin role" : " removed from admin role")
  end

  def another_palette_editor
    user_id = (params[:palette_user_id].present?) ? params[:palette_user_id].to_i : session[:palette_user_id].to_i
    @user = User.find(user_id)
    @palettes = @user.palettes
    flash[:notice] = "You are now viewing #{@user.full_name}'s palette.'"
  end


  def recommend_palettes
    Palette.recommend(params[:recommend_palette_ids], params[:recommend_user_ids])
    flash[:notice] = "Specified recommendations have been successfully made."
  end

  def clone_palette
    palette = Palette.find(params[:palette_id])
    @palette = Palette.clone palette, current_user
    recommend_palette = RecommendedPalette.find_by_user_id_and_palette_id(current_user.id, palette.id )
    recommend_palette.delete
    flash[:notice] = "The palette titled '#{palette.title}' was successfully cloned."
    @palettes = current_user.palettes
    @user = current_user
  end

  private

  def handle_params
    @user = User.find(params[:index])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
