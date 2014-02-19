class Button < ActiveRecord::Base
  belongs_to :user, inverse_of: :buttons

  validates :title, presence: true, uniqueness: true
  validates :speech_speed_rate, numericality: true
end
