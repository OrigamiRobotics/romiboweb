class AddAllButtonsSelectedColumnToPalettes < ActiveRecord::Migration[5.2]
  def change
    add_column :palettes, :all_buttons_selected, :boolean, default: false
  end
end
