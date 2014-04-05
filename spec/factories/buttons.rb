# == Schema Information
#
# Table name: buttons
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  speech_phrase     :string(255)
#  speech_speed_rate :float
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  button_color_id   :integer
#  size              :string(255)
#  row               :integer
#  col               :integer
#  selected          :boolean          default(FALSE)
#  palette_id        :integer
#
# Indexes
#
#  index_buttons_on_button_color_id  (button_color_id)
#  index_buttons_on_palette_id       (palette_id)
#  index_buttons_on_size             (size)
#  index_buttons_on_user_id          (user_id)
#

FactoryGirl.define do

  factory :button do
    title Faker::Name.name
    speech_phrase Faker::Lorem.sentence
    speech_speed_rate 0.3455
    user_id 1
    button_color_id 1
    size 'medium'
  end

end
