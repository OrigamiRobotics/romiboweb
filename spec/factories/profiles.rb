# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_name  :string(255)
#  user_id    :integer
#  avatar     :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user_name Faker::Internet.user_name
    avatar    Faker::Avatar.image
  end
end
