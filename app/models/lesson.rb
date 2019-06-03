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

class Lesson < ActiveRecord::Base
  
  CLASS_SIZES = %w(1 2 Small Large)

  acts_as_taggable
  
  belongs_to :user

  has_many :palette_lessons
  has_many :palettes, through: :palette_lessons
  has_many :lesson_subjects, inverse_of: :lesson
  has_many :subjects, through: :lesson_subjects
  has_many :recommended_lessons, inverse_of: :lesson, dependent: :destroy

  has_one :attachment, as: :attachable, dependent: :delete

  def subjects_for_show_page
    subjects.pluck(:name).join(" | ")
  end

  def self.recommend(lesson_ids, user_ids)
    lesson_ids.each do |recommended_palette_id|
      user_ids.each do  |recommended_user_id|
        RecommendedLesson.create(lesson_id: recommended_palette_id.to_i,
                                  user_id:  recommended_user_id.to_i)
      end
    end
  end

  def recommended?(by_user)
    by_user.id != self.user.id
  end

  def self.clone(source, new_owner)
    lesson = new_owner.lessons.build(source.attributes.except("id", "created_at", "updated_at", "user_id"))
    lesson.save

    clone_recommended_lesson_palettes source, new_owner, lesson
    clone_recommended_lesson_subjects source, lesson
  end

  private
  def self.clone_recommended_lesson_palettes(source, user, lesson)
    source.palettes.each do |palette|
      palette = Palette.clone(palette, user)
      PaletteLesson.create(palette_id: palette.id, lesson_id: lesson.id)
    end
  end

  def self.clone_recommended_lesson_subjects(source, lesson)
    source.subjects.each do |subject|
      LessonSubject.create(subject_id: subject.id, lesson_id: lesson.id)
    end
  end
end
