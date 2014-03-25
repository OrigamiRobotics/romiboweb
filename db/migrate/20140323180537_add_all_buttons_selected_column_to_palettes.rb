class AddAllButtonsSelectedColumnToPalettes < ActiveRecord::Migration
  def change
    add_column :palettes, :all_buttons_selected, :boolean, default: false
  end
end
