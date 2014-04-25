require 'openssl'

# Person with registered account in Romibo Web application. User may also be a Romibo owner.
#
# a. First Name: Person’s first name (also used in user greetings)
# b. Last Name: Person’s last name
# c. Email: (Registered email for the user, also used for sign-in)
# d. Password: (A secret text chosen by user for authentication)
#
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  password               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  auth_token             :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  twitter_nickname       :string(255)
#  encryption             :string(255)
#  encryption_key         :string(255)
#  encryption_iv          :string(255)
#  admin                  :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :omniauthable
  before_create :ensure_auth_token!

  has_many :buttons
  has_many :palettes, -> { order 'created_at' }, foreign_key: :owner_id, dependent: :destroy
  has_many :authentications, inverse_of: :user
  has_many :palette_viewers
  has_many :shared_palettes, class_name: 'Palette', through: :palette_viewers
  has_many :lessons
  has_many :recommended_palettes, inverse_of: :user, dependent: :destroy
  has_many :recommended_lessons,  inverse_of: :user, dependent: :destroy

  has_one :last_viewed_palette
  has_one :profile, inverse_of: :user


  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :terms, acceptance: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX } ,
            uniqueness:  { case_sensitive: false }

  after_save :create_default_palettes, :create_profile
  after_create :send_email_for_twitter

  include ApplicationHelper

  def create_profile
    profile = Profile.create(user_name: '', avatar: '', user_id: id) unless profile.present?
  end

  def send_email_for_twitter
    if provider == 'twitter' && uid.present? && email.present?
      AfterConfirmationMailer.welcome_mailer(self).deliver
    end
  end

  def confirm!
    old_confirmed_at = confirmed_at
    super

    if provider.nil? && uid.nil? && confirmed_at.present? && old_confirmed_at != confirmed_at
      AfterConfirmationMailer.welcome_mailer(self).deliver
    end
  end

  def create_default_palettes
    Palette.default_palettes(self) if self.confirmed_at_changed?
  end

  def current_palette
    if last_viewed_palette.present? && last_viewed_palette.palette.present?
      last_viewed_palette.palette
    else
      palettes.first
    end
  end

  def set_last_viewed_palette(palette)
    if is_owner?(palette)
      if last_viewed_palette.present?
        last_viewed_palette.palette = palette
        last_viewed_palette.save
      else
        lvp = build_last_viewed_palette palette_id: palette.id
        lvp.save
      end
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def reset_auth_token!
    self.update! auth_token: SecureRandom.hex
  end

  def apply_omniauth(omniauth)
    data = {provider: omniauth.provider, uid: omniauth.uid,
            confirmation_token: nil}
    data.merge!( confirmed_at: Time.now) if confirmed_at.blank?
    update_attributes(data)
  end

  def add_authentication(auth)
    User.create_user_authentication auth, self
  end

  def self.create_user_authentication(auth, user)
    auth_token = (auth.credentials.present?) ? auth.credentials.token : "fake"
    auth_nickname = (auth.info.present?) ? auth.info.nickname : "fake nickname"
    auth_image = (auth.info.present?) ? auth.info.image : "fake image url"
    if Rails.env.test?
      user = User.last
    end
    data = {name:      auth_name(auth),
            provider:  auth.provider,
            uid:       auth.uid,
            email:     auth_email(auth),
            token:     auth_token,
            nickname:  auth_nickname,
            image_url: auth_image,
            user_id:   user.id
    }
    a = Authentication.find_by_provider_and_uid(data[:provider], data[:uid])
    res = (a.present?) ? a.update_attributes(data) : Authentication.create(data)
    a.save if a
  end

  def self.auth_name(auth)
    info_name = (auth.info.present?) ? auth.info.name : auth.extra.raw_info.name
  end

  def self.auth_email(auth)
    info_email = (auth.info.present?) ? auth.info.email : auth.extra.raw_info.email
  end

  def self.from_twitter_oauth(auth)
    user = get_user_by_oauth auth
    if user
      user.apply_omniauth auth
      return user
    end

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

  def self.from_google_oauth2(access_token)
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


  def self.get_user_by_oauth (auth)
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

  def self.from_facebook_oauth(auth)
    user = get_user_by_oauth auth
    if user.present?
      user.apply_omniauth auth
      return user
    end
    user = user_from_auth(auth) if user.blank?
    user.apply_omniauth auth
    user
  end

  def self.user_from_auth(auth)
    user_from_auth_info auth
  end

  def self.user_from_auth_info(auth)
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

  def self.new_with_session(params, session)
    # if we have a session, use it to create a new user instance
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.from_omniauth(auth)
    if auth.provider == 'facebook'
      from_facebook_oauth auth
    elsif auth.provider == 'twitter'
      from_twitter_oauth auth
    elsif auth.provider == 'google_oauth2'
      from_google_oauth2 auth
    end
  end

  def encrypt_id
    data = "Very, very confidential data"

    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt

    encryption = cipher.update(data) + cipher.final
    encryption_key = cipher.random_key
    encryption_iv  = cipher.random_iv
  end


  def decrypted_id
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = encryption_key
    decipher.iv  = encryption_iv
    decipher.update(encryptd_id) + decipher.final
  end

  def other_names_and_avatars
    user_id = id
    User.where{id != user_id}.order(:first_name).map do |user|
      ["#{user.full_name},#{profile_avatar_url(user.profile)}", user.id]
    end
  end

  def palettes_to_recommend
    palettes.map do |palette|
      ["#{palette.title} (#{palette.buttons.size} buttons)", palette.id]
    end
  end

  def lessons_to_recommend
    lessons.map do |lesson|
      ["#{lesson.title[0..99]} ", lesson.id]
    end
  end
  private

  def ensure_auth_token!
    self.auth_token = SecureRandom.hex
  end

  def confirm_automatically
    if self.provider.present? && self.uid.present? and confirmed_at.nil?
      confirmed_at = Time.now if confirmed_at.nil?
      save
    end
  end

  def is_owner?(palette)
    palette.owner.id == id
  end
end
