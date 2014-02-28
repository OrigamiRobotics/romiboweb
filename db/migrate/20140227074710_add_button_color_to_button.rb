class AddButtonColorToButton < ActiveRecord::Migration
  def change
    remove_column :buttons, :color
    add_reference :buttons, :button_color, index: true
  end
end
