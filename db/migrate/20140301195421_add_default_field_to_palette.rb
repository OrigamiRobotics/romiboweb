class AddDefaultFieldToPalette < ActiveRecord::Migration[5.2]
  def change
    add_column :palettes, :system, :boolean, default: false
  end
end
