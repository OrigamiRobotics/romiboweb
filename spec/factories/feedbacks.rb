# == Schema Information
#
# Table name: feedbacks
#
#  id          :integer          not null, primary key
#  statement   :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_name   :string(255)
#  user_email  :string(255)
#  page_uri    :string(255)
#
# Indexes
#
#  index_feedbacks_on_user_id  (user_id)
#

FactoryGirl.define do

  factory :feedback do
    statement Faker::Name.name
    description Faker::Lorem.sentence
    user_name Faker::Name.name
    user_email Faker::Internet.email
  end

end
