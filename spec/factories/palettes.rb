FactoryGirl.define do

  factory :palette do
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    owner_id 1
  end

end