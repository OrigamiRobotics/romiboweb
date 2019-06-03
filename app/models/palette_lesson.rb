# == Schema Information
#
# Table name: palette_lessons
#
#  id         :bigint           not null, primary key
#  palette_id :bigint
#  lesson_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_palette_lessons_on_lesson_id   (lesson_id)
#  index_palette_lessons_on_palette_id  (palette_id)
#

class PaletteLesson < ActiveRecord::Base
  belongs_to :palette, inverse_of: :palette_lesson
  belongs_to :lesson, inverse_of: :palette_lesson
end
