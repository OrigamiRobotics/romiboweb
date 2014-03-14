class CreatePaletteViewers < ActiveRecord::Migration
  def change
    create_table :palette_viewers do |t|
      t.references :user
      t.references :palette

      t.timestamps
    end
  end
end
