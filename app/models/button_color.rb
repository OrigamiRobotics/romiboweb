class ButtonColor < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/i
  validates :value, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true

  has_many :buttons, inverse_of: :button_color
end
