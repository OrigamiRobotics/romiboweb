class ChangeLessonColumnsFromStringToText < ActiveRecord::Migration[5.2]
  def up
    change_column :lessons, :subject, :text
    change_column :lessons, :objectives, :text
    change_column :lessons, :materials, :text
    change_column :lessons, :preparation, :text
    change_column :lessons, :notes, :text
  end

  def down
    change_column :lessons, :subject, :string
    change_column :lessons, :objectives, :string
    change_column :lessons, :materials, :string
    change_column :lessons, :preparation, :string
    change_column :lessons, :notes, :string
  end
end
