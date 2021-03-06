# Button Color contains name and hexadecmal value for that color. The default color for a Button is Turquoise.
#
# a. Id: Auto generated unique identifier
# b. Name: Color Name
# c. Value: Hexadecimal Value for Color
#    1. Red '#c1392d'
#    2. Orange '#d45300'
#    3. Yellow '#f39b13'
#    4. Light Green '#2dcc70'
#    5. Green '#27ae61'
#    6. Turquoise '#13c8b0'
#    7. Blue '#3498db'
#    8. Purple '#8d44af'
#    9. Pink '#fe7a7a'
#
# == Schema Information
#
# Table name: button_colors
#
#  id         :bigint           not null, primary key
#  name       :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_button_colors_on_name_and_value  (name,value)
#

class ButtonColor < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/i
  validates :value, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true

  has_many :buttons, inverse_of: :button_color
  
  def self.default
    ButtonColor.find_by_name('Turquoise')
  end
end
