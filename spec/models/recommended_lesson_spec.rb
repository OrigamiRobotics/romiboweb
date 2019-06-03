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

require 'spec_helper'

describe RecommendedLesson do
  pending "add some examples to (or delete) #{__FILE__}"
end
