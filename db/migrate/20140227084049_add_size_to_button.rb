class AddSizeToButton < ActiveRecord::Migration[5.2]
  def change
    add_column :buttons, :size, :string
    add_index :buttons, :size
  end
end
