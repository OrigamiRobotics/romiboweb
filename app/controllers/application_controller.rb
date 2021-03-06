class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    if cookies[:user_locale]
      I18n.locale = cookies[:user_locale]
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :terms])
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end


  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  helper_method :resource, :resource_name, :devise_mapping

  def set_gon
    gon.controller = params[:controller]
    gon.action     = params[:action]
  end

  def set_session
    session[:adding_button] = false
  end
end
