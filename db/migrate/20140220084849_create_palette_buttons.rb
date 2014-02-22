class CreatePaletteButtons < ActiveRecord::Migration
  def change
    create_table :palette_buttons do |t|
      t.references :palette, index: true
      t.references :button, index: true

      t.timestamps
    end
  end
end
