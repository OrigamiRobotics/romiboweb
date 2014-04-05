class AddPaletteIdToButtons < ActiveRecord::Migration
  def change
    add_reference :buttons, :palette, index: true
  end
end
