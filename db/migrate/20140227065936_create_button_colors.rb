class CreateButtonColors < ActiveRecord::Migration
  def change
    create_table :button_colors do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
    add_index :button_colors, [:name, :value]

  end

end
