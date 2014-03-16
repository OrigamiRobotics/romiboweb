# == Schema Information
#
# Table name: last_viewed_palettes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  palette_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class LastViewedPalette < ActiveRecord::Base
  belongs_to :user, inverse_of: :last_viewed_palette
  belongs_to :palette, inverse_of: :last_viewed_palette
end
