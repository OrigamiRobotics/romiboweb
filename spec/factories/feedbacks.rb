# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  email      :string(255)
#

FactoryGirl.define do

  factory :feedback do
    title Faker::Name.name
    content Faker::Lorem.sentence
    user_id 1
  end

end
