FactoryGirl.define do

  factory :palette do
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    owner {FactoryGirl.create(:user, email: 'test@test.com')}
  end

end