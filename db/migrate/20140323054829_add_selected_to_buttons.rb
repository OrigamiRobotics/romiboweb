class AddSelectedToButtons < ActiveRecord::Migration
  def change
    add_column :buttons, :selected, :boolean, default: false
  end
end
