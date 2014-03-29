# == Schema Information
#
# Table name: palettes
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :string(255)
#  color              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  owner_id           :integer
#  system             :boolean          default(FALSE)
#  last_viewed_button :integer
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
