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

FactoryGirl.define do

  factory :last_viewed_palette do
    user_id 1
    palette_id 1
  end

end
