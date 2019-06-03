# == Schema Information
#
# Table name: buttons
#
#  id                :bigint           not null, primary key
#  title             :string           not null
#  speech_phrase     :string
#  speech_speed_rate :float
#  user_id           :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  button_color_id   :bigint
#  size              :string
#  row               :integer
#  col               :integer
#  selected          :boolean          default(FALSE)
#  palette_id        :bigint
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
    palette_id 1
  end

end
