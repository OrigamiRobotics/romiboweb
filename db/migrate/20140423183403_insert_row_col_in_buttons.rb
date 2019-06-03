class InsertRowColInButtons < ActiveRecord::Migration[5.2]
  def up
    Palette.find_each do |palette|
      @row = 1
      @col = 1
      palette.buttons.order(:id).each do |button|
        button_size = Button::SIZE[button.size.downcase]
        if (@col + button_size) > 13
          @col = 1
          @row = @row + 1
        end
        button.row = @row
        button.col = @col
        button.user ||= palette.owner
        button.save!
        @col = @col + button_size
      end
    end
  end
  def down
  end
end
