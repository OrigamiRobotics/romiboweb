FactoryGirl.define do

  factory :button do
    title Faker::Name.name
    color "#000000"
    speech_phrase Faker::Lorem.sentence
    speech_speed_rate 0.3455
    user_id 1
  end

end