class AddSizeToButton < ActiveRecord::Migration
  def change
    add_column :buttons, :size, :string
    add_index :buttons, :size
  end
end
