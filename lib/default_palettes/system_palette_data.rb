module DefaultPalettes

  class SimplePalette < Struct.new(:title, :buttons); end
  class SimpleButton < Struct.new(:title, :speech, :speed_rate); end

  class SystemPaletteData

    def load_file(filename)
      JSON.parse(IO.read(filename))
    end

    def make_button(data)
      button = SimpleButton.new(data["buttonTitle"], data["speechPhrase"],
                                data["speechSpeedRate"])
    end

    def palettes
      palettes = []
      (1..4).each do |index|
        data = load_file("lib/tasks/data/sample_palettes#{index}.json")
        palette = SimplePalette.new(data["name"])
        actions = data['actions']
        buttons = []
        actions.each do |action|
          buttons << make_button(action)
        end
        palette.buttons = buttons
        palettes << palette
      end
      palettes
    end
  end


end