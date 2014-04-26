# == Schema Information
#
# Table name: lesson_subjects
#
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  subject_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_lesson_subjects_on_lesson_id   (lesson_id)
#  index_lesson_subjects_on_subject_id  (subject_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson_subject do
    lesson nil
    subject nil
  end
end
