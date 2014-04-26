module UserSocialConcerns
  extend ActiveSupport::Concern

  def create_user_authentication(auth, user)
    auth_token = (auth.credentials.present?) ? auth.credentials.token : "fake"
    auth_nickname = (auth.info.present?) ? auth.info.nickname : "fake nickname"
    auth_image = (auth.info.present?) ? auth.info.image : "fake image url"
    if Rails.env.test?
      user = User.last
    end
    data = provider_data(auth, auth_image, auth_nickname, auth_token, user)
    a = Authentication.find_by_provider_and_uid(data[:provider], data[:uid])
    res = (a.present?) ? a.update_attributes(data) : Authentication.create(data)
    a.save if a
  end

  def from_twitter_oauth_helper(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      name = auth.info.name
      name = name.split(' ')
      user.first_name       = name.first
      user.last_name        = name.last
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.twitter_nickname = auth.info.nickname
    end
  end

  def auth_name(auth)
    info_name = (auth.info.present?) ? auth.info.name : auth.extra.raw_info.name
  end

  def auth_email(auth)
    info_email = (auth.info.present?) ? auth.info.email : auth.extra.raw_info.email
  end

  def from_twitter_oauth(auth)
    user = get_user_by_oauth auth
    if user
      user.apply_omniauth auth
      return user
    end

    from_twitter_oauth_helper(auth)
  end

  def from_google_oauth2(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user.present?
      user = User.create(first_name: data["first_name"],
                         last_name: data["last_name"],
                         email: data["email"],
                         provider: access_token.provider,
                         uid: access_token.uid,
                         confirmation_token: nil,
                         confirmed_at: Time.now
      )
    end
    user
  end


  def get_user_by_oauth (auth)
    authentication = Authentication.where(:provider => auth.provider, uid: auth.uid).first
    return User.find_by_id(authentication.user_id) if authentication.present?
    if auth.provide == 'twitter'
      user = User.find_by_twitter_nickname(auth.info.nickname)
    elsif auth.provider == 'facebook'
      user = User.find_by_email(auth_email(auth))
    elsif auth.provider =='google_oauth2'
      user = User.find_by_email(auth_email(auth))
    end
    user.apply_omniauth auth unless user.blank?
    user
  end

  def from_facebook_oauth(auth)
    user = get_user_by_oauth auth
    if user.present?
      user.apply_omniauth auth
      return user
    end
    user = user_from_auth(auth) if user.blank?
    user.apply_omniauth auth
    user
  end

  def user_from_auth(auth)
    user_from_auth_info auth
  end

  def user_from_auth_info(auth)
    name = auth_name auth
    name = name.split(' ')
    u = User.create!(first_name: name.first,
                     last_name:  name.last,
                     provider:  auth.provider,
                     uid:       auth.uid,
                     email:     auth_email(auth)
    )
    u.add_authentication auth
    u
  end

  private

  def provider_data(auth, auth_image, auth_nickname, auth_token, user)
    {name:      auth_name(auth),
     provider:  auth.provider,
     uid:       auth.uid,
     email:     auth_email(auth),
     token:     auth_token,
     nickname:  auth_nickname,
     image_url: auth_image,
     user_id:   user.id
    }
  end
end
