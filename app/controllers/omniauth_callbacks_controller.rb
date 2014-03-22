require 'prettyprint'
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    omniauth = request.env["omniauth.auth"]
    if current_user.present?
      authenticate_and_update_attributes omniauth
    else
      user = User.from_omniauth(omniauth)
      if user.persisted?
        authenticate_new_user user, omniauth
        sign_in_new_user user, omniauth
      else
        if user.confirmed_at != nil
          flash[:notice] = "Authentication with " +  omniauth['provider'].capitalize + " successful!"
          sign_in_and_redirect user
        else
          handle_incomplete user, omniauth
        end
      end
    end
  end


  alias_method :twitter,   :all
  alias_method :facebook,  :all
  alias_method :google_oauth2, :all

  private
  def add_authentication?(omniauth)
     ((email_matches?omniauth) && !(already_authenticated_by? omniauth['provider']))
  end

  def email_matches?(omniauth)
    if (omniauth['provider'] == 'facebook') || (omniauth['provider'] == 'google_auth2')
      current_user.email == omniauth.extra.raw_info.email
    end
  end

  def nickname_matches?(omniauth)
    Authentication.find_by_nickname(omniauth.info.nickame)
  end

  def already_authenticated_by?(provider)
    current_user.authentications.where(:provider => provider).present?
  end

  def create_user_authentication(auth, user)
    User.create_user_authentication auth, user
  end

  def authenticate_new_user(user, omniauth)
    user_id = user.id
    prov =  omniauth['provider']
    u_id =  omniauth['uid']
    auth = Authentication.where{(provider == prov) & (uid == u_id) & (user_id == u_id)}
    create_user_authentication(omniauth, user) if auth.blank?
  end

  def sign_in_new_user(user, omniauth)

    if user.confirmed_at != nil
      flash.notice = "Authentication with " +  omniauth['provider'].capitalize + " successful!"
      sign_in_and_redirect user
    else
      redirect_to :controller => 'users', :action => 'unconfirmed', :index => user.id
    end
  end

  def authenticate_and_update_attributes(omniauth)
    provider = omniauth['provider']
    create_user_authentication omniauth, current_user
    if (omniauth['provider'] == 'facebook') or (omniauth['provider'] != 'linkedin') or (omniauth['provider'] != 'gmail')
      current_user.update_attributes(provider: provider, uid: omniauth['uid']) if (add_authentication? omniauth)
    else
      current_user.update_attributes(provider: provider, uid: omniauth['uid'], twitter_nickname: omniauth['info']['nickname'])
    end
  end

  def handle_incomplete(user, omniauth)
    session["devise.user_attributes"] = user.attributes
    flash[:error] = 'Oops!, It looks like you are missing some vital information'

    if omniauth['provider'] == 'twitter'
      flash[:error] = 'Your authentication with Twitter was successful, but we need your email address to complete the process.'
      redirect_to new_user_registration_url
    end
  end
end


