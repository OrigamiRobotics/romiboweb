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
  include ApplicationHelper
  extend  UserSocialConcerns
  include UserConcerns

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

  def add_authentication(auth)
    User.create_user_authentication auth, self
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

  def last_viewed_palette_id
    last_viewed_palette.palette_id
  end

  def confirmed
    if confirmed_at.blank?
      0
    else
      1
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
