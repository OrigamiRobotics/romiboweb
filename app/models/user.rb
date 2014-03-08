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
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :buttons
  has_many :palettes, -> { order 'created_at' }, foreign_key: :owner_id
  has_many :feedbacks
  has_one :last_viewed_palette

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX } ,
            uniqueness:  { case_sensitive: false }

  def my_palettes
    unless Palette.where{(owner_id == id) && (system == true)}.present?
      Palette.default_palettes(self)
    end

    palettes
  end

  def current_palette
    if last_viewed_palette.present? && last_viewed_palette.palette.present?
      last_viewed_palette.palette
    else
      my_palettes.first
    end
  end

  def set_last_viewed_palette(palette)
    if last_viewed_palette.present?
      last_viewed_palette.palette = palette
      last_viewed_palette.save
    else
      lvp = build_last_viewed_palette palette_id: palette.id
      lvp.save
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end
