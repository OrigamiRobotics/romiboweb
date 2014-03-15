namespace :data do
  desc "Generate default button colors"
  task :seed_colors  => :environment do
    colors =  [
    "Red #c1392d",
    "Orange #d45300",
    "Yellow #f39b13",
    "Green #27ae61",
    "Light Green #2dcc70",
    "Blue #297fb8",
    "Turquoise #13c8b0",
    "Purple #8d44af",
    "Pink #fe7a7a"
    ]

    ButtonColor.all.destroy_all
    colors.each do | color|
      val = color[-7..-1]
      nom  = color[0..color.size - 9]
      ButtonColor.find_or_create_by_name_and_value(name: nom, value: val)
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

