class LastViewedPalette < ActiveRecord::Base
  belongs_to :user, inverse_of: :last_viewed_palette
  belongs_to :palette, inverse_of: :last_viewed_palette
end
