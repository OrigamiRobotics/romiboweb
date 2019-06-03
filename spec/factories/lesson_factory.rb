# == Schema Information
#
# Table name: lessons
#
#  id                :bigint           not null, primary key
#  title             :string
#  subject           :text
#  duration          :integer
#  objectives        :text
#  materials         :text
#  no_of_instructors :string
#  student_size      :string
#  preparation       :text
#  notes             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_lessons_on_user_id  (user_id)
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
