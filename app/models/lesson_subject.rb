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

class LessonSubject < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :subject
end
