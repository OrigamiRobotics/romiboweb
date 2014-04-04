# == Schema Information
#
# Table name: lessons
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  subject           :string(255)
#  duration          :integer
#  objectives        :string(255)
#  materials         :string(255)
#  no_of_instructors :string(255)
#  student_size      :string(255)
#  preparation       :string(255)
#  notes             :string(255)
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
