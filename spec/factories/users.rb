# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    email 'example1@example.com'
    password 'please'
    #password_confirmation 'please'
    #confirmed_at Time.now
  end
end