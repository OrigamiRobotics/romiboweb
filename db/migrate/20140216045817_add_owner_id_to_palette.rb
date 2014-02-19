class AddOwnerIdToPalette < ActiveRecord::Migration
  def change
    add_column :palettes, :owner_id, :integer
  end
end
