class CreatePaletteButtons < ActiveRecord::Migration[5.2]
  def change
    create_table :palette_buttons do |t|
      t.references :palette, index: true
      t.references :button, index: true

      t.timestamps
    end
  end
end
