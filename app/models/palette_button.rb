# PaletteButton is a mapping table for Palette and Button.
#
# == Schema Information
#
# Table name: palette_buttons
#
#  id         :bigint           not null, primary key
#  palette_id :bigint
#  button_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_palette_buttons_on_button_id   (button_id)
#  index_palette_buttons_on_palette_id  (palette_id)
#

class PaletteButton < ActiveRecord::Base
  belongs_to :palette, inverse_of: :palette_buttons
  belongs_to :button, inverse_of: :palette_buttons
end
