# == Schema Information
#
# Table name: palettes
#
#  id                   :bigint           not null, primary key
#  title                :string
#  description          :string
#  color                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  owner_id             :integer
#  system               :boolean          default(FALSE)
#  last_viewed_button   :integer
#  all_buttons_selected :boolean          default(FALSE)
#

FactoryGirl.define do

  factory :palette do
    title 'Fancy Palette'
    description Faker::Lorem.paragraph
    owner_id 1
    factory :palette_with_buttons do
      ignore do
        count 5
      end
      after(:create) do |palette, eval|
        FactoryGirl.create_list(:palette_button, eval.count, palette: palette)
      end
    end
  end

  factory :palette_button do
    association :palette
    association :button
  end

end
