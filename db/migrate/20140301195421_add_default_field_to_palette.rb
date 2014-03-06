class AddDefaultFieldToPalette < ActiveRecord::Migration
  def change
    add_column :palettes, :system, :boolean, default: false
  end
end
