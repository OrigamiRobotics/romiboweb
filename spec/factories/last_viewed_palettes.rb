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
# Indexes
#
#  index_last_viewed_palettes_on_palette_id  (palette_id)
#  index_last_viewed_palettes_on_user_id     (user_id)
#

FactoryGirl.define do

  factory :last_viewed_palette do
    user_id 1
    palette_id 1
  end

end
