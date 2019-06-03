class RemoveLightGreenAndOrangeColorsFromButtonColors < ActiveRecord::Migration[5.2]
  def change
    execute "UPDATE buttons
            SET button_color_id=(select id FROM button_colors WHERE name='Green')
            WHERE button_color_id=(select id FROM button_colors WHERE name='Light Green')"

    execute "UPDATE buttons
            SET button_color_id=(select id FROM button_colors WHERE name='Yellow')
            WHERE button_color_id=(select id FROM button_colors WHERE name='Orange')"

    execute "DELETE FROM button_colors WHERE name='Light Green' OR name='Orange'"
  end
end
