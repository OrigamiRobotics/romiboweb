class AddButtonColorToButton < ActiveRecord::Migration[5.2]
  def change
    remove_column :buttons, :color
    add_reference :buttons, :button_color, index: true
  end
end
