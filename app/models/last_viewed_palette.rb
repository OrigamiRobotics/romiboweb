# == Schema Information
#
# Table name: last_viewed_palettes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  palette_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_last_viewed_palettes_on_palette_id  (palette_id)
#  index_last_viewed_palettes_on_user_id     (user_id)
#

class LastViewedPalette < ActiveRecord::Base
  belongs_to :user, inverse_of: :last_viewed_palette
  belongs_to :palette, inverse_of: :last_viewed_palette
end
