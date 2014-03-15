module DefaultPalette

  def load
    @palettes || load_csv
  end

  def i_spy
    load[:i_spy]
  end

  def simon_says
    load[:simon_says]
  end

  def tell_me_a_story
    load[:tell_me_a_story]
  end

  def draw_with_me
    load[:draw_with_me]
  end

  private

  def load_csv
    csv_file = 'lib/tasks/data/RobotPhrasePallets.csv'

    @palettes = {}
    data = SmarterCSV.process(csv_file)
    data.each do |value|
      (0..17).each do |index|
        if @palettes[value.keys[index]].nil?
          @palettes[value.keys[index]] = [value.values[index]]
        else
          @palettes[value.keys[index]] << value.values[index]
        end
      end
    end
    @palettes
  end
end