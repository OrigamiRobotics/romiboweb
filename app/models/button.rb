# == Schema Information
#
# Table name: buttons
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  color             :string(255)
#  speech_phrase     :string(255)
#  speech_speed_rate :float
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Button < ActiveRecord::Base
  belongs_to :user, inverse_of: :buttons
  has_many :palette_buttons
  has_many :palettes, through: :palette_buttons

  validates :title, presence: true
  validates :speech_speed_rate, numericality: true
  validates :user_id, presence: true
end
