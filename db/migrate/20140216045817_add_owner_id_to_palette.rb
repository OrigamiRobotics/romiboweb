class AddOwnerIdToPalette < ActiveRecord::Migration[5.2]
  def change
    add_column :palettes, :owner_id, :integer
  end
end
