class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :subject
      t.float :duration
      t.string :objectives
      t.string :materials
      t.string :no_of_instructors
      t.string :student_size
      t.string :preparation
      t.string :notes

      t.timestamps
    end
  end
end
