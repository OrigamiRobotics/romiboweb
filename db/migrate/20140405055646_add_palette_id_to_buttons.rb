class AddPaletteIdToButtons < ActiveRecord::Migration
  def change
    add_reference :buttons, :palette, index: true
    
    reversible do |dir|
      dir.up do
        Palette.all.each do |palette|
          palette.palette_buttons.each do |palette_button|
            palette_button.button.update_attributes(palette_id: palette.id) unless palette_button.button.nil?
          end
        end
      end
      
      dir.down do
        # raise ActiveRecord::IrreversibleMigration
      end
    end
  end
  
end


