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
#    7. Blue '#297fb8'
#    8. Purple '#8d44af'
#    9. Pink '#fe7a7a'
#
# == Schema Information
#
# Table name: button_colors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
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
end
