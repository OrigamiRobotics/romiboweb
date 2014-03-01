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
  belongs_to :button_color, inverse_of: :buttons

  validates :title, presence: true
  validates :speech_speed_rate, numericality: true
  validates :user_id, presence: true
  validates :button_color_id, presence: true
  validates :size, presence: true, inclusion: { in: %w(small Small medium Medium large Large)}

  def color
    button_color.value
  end

  def div_id
    "#{title}_#{id}"
  end
end
