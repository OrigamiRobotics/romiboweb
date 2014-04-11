class CreatePaletteLessons < ActiveRecord::Migration
  def change
    create_table :palette_lessons do |t|
      t.references :palette, index: true
      t.references :lesson, index: true

      t.timestamps
    end
  end
end
