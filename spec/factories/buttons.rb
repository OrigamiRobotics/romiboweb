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

FactoryGirl.define do

  factory :button do
    title Faker::Name.name
    color "#000000"
    speech_phrase Faker::Lorem.sentence
    speech_speed_rate 0.3455
    user_id 1
  end

end
