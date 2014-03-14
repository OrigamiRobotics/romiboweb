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
  end

end
