# == Schema Information
#
# Table name: lesson_subjects
#
#  id         :bigint           not null, primary key
#  lesson_id  :bigint
#  subject_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_lesson_subjects_on_lesson_id   (lesson_id)
#  index_lesson_subjects_on_subject_id  (subject_id)
#

class LessonSubject < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :subject
end
