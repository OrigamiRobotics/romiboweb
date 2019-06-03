class CreateRecommendedPalettes < ActiveRecord::Migration[5.2]
  def change
    create_table :recommended_palettes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :palette, index: true

      t.timestamps
    end
  end
end
