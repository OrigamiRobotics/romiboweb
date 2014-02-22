class Button < ActiveRecord::Base
  belongs_to :user, inverse_of: :buttons
  has_many :palette_buttons
  has_many :palettes, through: :palette_buttons

  validates :title, presence: true
  validates :speech_speed_rate, numericality: true
  validates :user_id, presence: true
end
