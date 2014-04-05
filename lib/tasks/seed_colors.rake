namespace :data do
  desc "Generate default button colors"
  task :seed_colors  => :environment do

    colors =  [
      "Red #c1392d",
      "Yellow #f39b13",
      "Green #27ae61",
      "Turquoise #13c8b0",
      "Blue #297fb8",
      "Purple #8d44af",
      "Pink #fe7a7a"
    ]

    color_values = {}
    #store current button color ids
    ButtonColor.all.each do |color|
      color_values[color.id] = color.name
    end

    light_green_id = ButtonColor.find_by_name('Light Green')
    light_green_id = light_green_id.id if light_green_id.present?

    orange_id =  ButtonColor.find_by_name('Orange')
    orange_id = orange_id.id if orange_id.present?

    #change light green to green
    unless light_green_id.nil?
      green_color_id      = ButtonColor.find_by_name('Green').id

      light_green_buttons = Button.where{button_color_id == light_green_id}
      light_green_buttons.update_all(button_color_id: green_color_id)
    end

    #change orange to yellow
    unless orange_id.nil?
      yellow_id      = ButtonColor.find_by_name('Yellow').id

      orange_buttons = Button.where{button_color_id == orange_id}
      orange_buttons.update_all(button_color_id: yellow_id)
    end


    ButtonColor.all.destroy_all
    colors.each do | color|
      val = color[-7..-1]
      nom  = color[0..color.size - 9]
      ButtonColor.find_or_create_by_name_and_value(name: nom, value: val)
    end

    #ensure that existing buttons have the correct button color ids
    Button.all.each do |button|
      color = ButtonColor.find_by_name(color_values[button.button_color_id])
      button.update_attributes(button_color_id: color.id)
    end

  end

  #"#1ABC9C TURQUOISE",
  #    "#16A085 GREEN SEA",
  #    "#2ECC71 EMERALD",
  #    "#27AE60 NEPHRITIS",
  #    "#3498DB PETER RIVER",
  #    "#2980B9 BELIZE HOLE",
  #    "#9B59B6 AMETHYST",
  #    "#8E44AD WISTERIA",
  #    "#34495E WET ASPHALT",
  #    "#2C3E50 MIDNIGHT BLUE",
  #    "#F1C40F SUN FLOWER",
  #    "#F39C12 ORANGE",
  #    "#E67E22 CARROT",
  #    "#D35400 PUMPKIN",
  #    "#E74C3C ALIZARIN",
  #    "#C0392B POMEGRANATE",
  #    "#ECF0F1 CLOUDS",
  #    "#BDC3C7 SILVER",
  #    "#95A5A6 CONCRETE",
  #    "#7F8C8D ASBESTOS"
end

