FactoryGirl.define do

  factory :feedback do
    title Faker::Name.name
    content Faker::Lorem.sentence
    user_id 1
  end

end
