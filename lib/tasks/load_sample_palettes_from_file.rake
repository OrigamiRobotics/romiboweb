require 'json'


namespace :data do
  desc "Generate default button colors"

  class SimpleButton < Struct.new(:speech, :title, :speed_rate); end

  def load_file(filename)
    JSON.parse(IO.read(filename))
  end

  def make_button(data, palette_id)
    button = SimpleButton.new(data["speechPhrase"], data["buttonTitle"],
                             data["speechSpeedRate"])

  end

  task :load_palettes  => :environment do
    (1..4).each do |index|
      data = load_file("lib/tasks/data/sample_palettes#{index}.json")
      puts data["name"]
      #actions = data['actions']
      #actions.each do |action|
      #  make_button action
      #end
    end
  end
end