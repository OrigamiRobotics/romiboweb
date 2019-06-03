class AddRowColToButtons < ActiveRecord::Migration[5.2]
  def change
    add_column :buttons, :row, :integer
    add_column :buttons, :col, :integer
  end
end
