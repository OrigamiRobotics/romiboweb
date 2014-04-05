namespace :data do
  desc "Assign palette ids to existing buttons"
  task :assign_button_palette_ids => :environment do
    Palette.all.each do |palette|
      palette.palette_buttons.each do |palette_button|
        palette_button.button.update_attributes(palette_id: palette.id) unless palette_button.button.palette.present?
      end
    end
  end
end

