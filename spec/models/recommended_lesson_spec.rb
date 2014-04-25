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

require 'spec_helper'

describe RecommendedLesson do
  pending "add some examples to (or delete) #{__FILE__}"
end
