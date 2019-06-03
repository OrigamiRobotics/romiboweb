# == Schema Information
#
# Table name: feedbacks
#
#  id          :bigint           not null, primary key
#  statement   :string
#  description :text
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_name   :string
#  user_email  :string
#  page_uri    :string
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
    page_uri Faker::Internet.url
  end

end
