class UpdateBlueToRiverBlue < ActiveRecord::Migration
  def change
    execute "UPDATE button_colors
            SET value='#3498db'
            WHERE name='Blue'"
  end
end
