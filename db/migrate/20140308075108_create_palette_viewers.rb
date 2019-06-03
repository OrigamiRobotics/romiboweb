class CreatePaletteViewers < ActiveRecord::Migration[5.2]
  def change
    create_table :palette_viewers do |t|
      t.references :user
      t.references :palette

      t.timestamps
    end
  end
end
