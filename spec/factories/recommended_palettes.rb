# == Schema Information
#
# Table name: recommended_palettes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  palette_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_recommended_palettes_on_palette_id  (palette_id)
#  index_recommended_palettes_on_user_id     (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommended_palette do
    user nil
    palette nil
  end
end
