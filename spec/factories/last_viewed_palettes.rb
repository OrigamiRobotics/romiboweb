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

FactoryGirl.define do

  factory :last_viewed_palette do
    user_id 1
    palette_id 1
  end

end
