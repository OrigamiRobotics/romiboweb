namespace :data do

  desc "Generate CSS for button colors"
  task :make_button_color_classes => :environment do
    ButtonColor.all.each do |color|
      puts  ".#{color.name.downcase.gsub(/ /, '-')}ButtonColor {\n" +
        "  background-color: #{color.value};\n" +
        "}\n\n"
    end
  end
end

