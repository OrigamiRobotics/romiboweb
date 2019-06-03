# == Schema Information
#
# Table name: recommended_lessons
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  lesson_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
