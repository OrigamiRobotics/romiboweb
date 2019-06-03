# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  user_name  :string
#  user_id    :bigint
#  avatar     :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_profiles_on_slug     (slug) UNIQUE
#  index_profiles_on_user_id  (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user_name Faker::Internet.user_name
    avatar    Faker::Avatar.image
  end
end
