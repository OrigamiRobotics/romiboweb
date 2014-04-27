# == Schema Information
#
# Table name: recommended_lessons
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  lesson_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_recommended_lessons_on_lesson_id  (lesson_id)
#  index_recommended_lessons_on_user_id    (user_id)
#

class RecommendedLesson < ActiveRecord::Base
  belongs_to :user  , inverse_of: :recommended_lessons
  belongs_to :lesson, inverse_of: :recommended_lessons
end
