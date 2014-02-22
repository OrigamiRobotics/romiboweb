class PaletteButton < ActiveRecord::Base
  belongs_to :palette, inverse_of: :palette_buttons
  belongs_to :button, inverse_of: :palette_buttons
end
