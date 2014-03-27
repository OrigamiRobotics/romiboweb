class AddRowColToButtons < ActiveRecord::Migration
  def change
    add_column :buttons, :row, :integer
    add_column :buttons, :col, :integer
  end
end
