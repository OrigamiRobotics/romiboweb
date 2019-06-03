class AddSelectedToButtons < ActiveRecord::Migration[5.2]
  def change
    add_column :buttons, :selected, :boolean, default: false
  end
end
