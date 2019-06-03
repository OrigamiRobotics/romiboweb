# == Schema Information
#
# Table name: recommended_palettes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  palette_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
