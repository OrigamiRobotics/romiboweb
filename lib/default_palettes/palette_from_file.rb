module DefaultPalettes

  class PaletteFromFile

    def parse(content)
      JSON.parse(content)
    end

    def make_button(data)
      button = SimpleButton.new(data["buttonTitle"], data["speechPhrase"],
                                data["speechSpeedRate"])
    end

    def palette(file_content)
      data = parse(file_content)
      palette = SimplePalette.new(data["name"])
      actions = data['actions']
      buttons = []
      actions.each do |action|
        buttons << make_button(action)
      end
      palette.buttons = buttons
      palette
    end

  end
end