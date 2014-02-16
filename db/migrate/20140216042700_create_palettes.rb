class CreatePalettes < ActiveRecord::Migration
  def change
    create_table :palettes do |t|
      t.string :title
      t.string :description
      t.string :color

      t.timestamps
    end
  end
end
