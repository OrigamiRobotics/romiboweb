class CreateRecommendedLessons < ActiveRecord::Migration
  def change
    create_table :recommended_lessons do |t|
      t.belongs_to :user, index: true
      t.belongs_to :lesson, index: true

      t.timestamps
    end
  end
end
