namespace :data do
  desc "Generate default button colors"
  task :seed_colors  => :environment do
    colors =  [
      "#1ABC9C TURQUOISE",
      "#16A085 GREEN SEA",
      "#2ECC71 EMERALD",
      "#27AE60 NEPHRITIS",
      "#3498DB PETER RIVER",
      "#2980B9 BELIZE HOLE",
      "#9B59B6 AMETHYST",
      "#8E44AD WISTERIA",
      "#34495E WET ASPHALT",
      "#2C3E50 MIDNIGHT BLUE",
      "#F1C40F SUN FLOWER",
      "#F39C12 ORANGE",
      "#E67E22 CARROT",
      "#D35400 PUMPKIN",
      "#E74C3C ALIZARIN",
      "#C0392B POMEGRANATE",
      "#ECF0F1 CLOUDS",
      "#BDC3C7 SILVER",
      "#95A5A6 CONCRETE",
      "#7F8C8D ASBESTOS"
    ]

    colors.each do | color|
      val = color[0..6]
      nom  = color[8..-1]
      ButtonColor.find_or_create_by_name_and_value(name: nom, value: val)
    end
  end
end

