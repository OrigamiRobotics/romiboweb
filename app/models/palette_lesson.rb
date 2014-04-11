# == Schema Information
#
# Table name: palette_lessons
#
#  id         :integer          not null, primary key
#  palette_id :integer
#  lesson_id  :integer
#  created_at :datetime
#  updated_at :datetime
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
