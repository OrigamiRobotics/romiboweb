class AddLastViewedButtonToPalette < ActiveRecord::Migration
  def change
    add_column :palettes, :last_viewed_button, :integer
  end
end
