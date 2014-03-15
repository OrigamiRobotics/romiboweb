require 'json'
require 'csv'
require 'pp'

namespace :data do
  desc "Load default system palettes from file"

  task :load_csv_palettes  => :environment do

    #csv_text = File.read('lib/tasks/data/RobotPhrasePallets.csv')
    #csv = CSV.parse(csv_text, :headers => true)
    #csv.each do |row|
    #  puts row.to_yaml
    #end
    csv_file = 'lib/tasks/data/RobotPhrasePallets.csv'

    palettes = {}
    data = SmarterCSV.process(csv_file)
    data.each do |value|
      (0..17).each do |index|
        if palettes[value.keys[index]].nil?
          palettes[value.keys[index]] = [value.values[index]]
        else
          palettes[value.keys[index]] << value.values[index]
        end
      end
    end
    pp palettes
  end
end