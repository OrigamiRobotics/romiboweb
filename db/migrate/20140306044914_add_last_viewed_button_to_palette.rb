class AddLastViewedButtonToPalette < ActiveRecord::Migration[5.2]
  def change
    add_column :palettes, :last_viewed_button, :integer
  end
end
