# == Schema Information
#
# Table name: lessons
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  subject           :text
#  duration          :integer
#  objectives        :text
#  materials         :text
#  no_of_instructors :string(255)
#  student_size      :string(255)
#  preparation       :text
#  notes             :text
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#

FactoryGirl.define do
  factory :lesson do |f|
    f.title Faker::Lorem.sentence
    f.subject Faker::Lorem.paragraph
    f.duration 30
    f.objectives Faker::Lorem.paragraph
    f.materials Faker::Lorem.paragraph
    f.no_of_instructors 1
    f.student_size '1'
    f.preparation Faker::Lorem.paragraph
    f.notes Faker::Lorem.paragraph
    user
  end
end
