# == Schema Information
#
# Table name: palette_buttons
#
#  id         :integer          not null, primary key
#  palette_id :integer
#  button_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class PaletteButton < ActiveRecord::Base
  belongs_to :palette, inverse_of: :palette_buttons
  belongs_to :button, inverse_of: :palette_buttons
end
