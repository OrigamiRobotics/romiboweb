class CreateLessonSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_subjects do |t|
      t.belongs_to :lesson,  index: true
      t.belongs_to :subject, index: true

      t.timestamps
    end
  end
end
