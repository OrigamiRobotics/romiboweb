# == Schema Information
#
# Table name: button_colors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#


FactoryGirl.define do

  factory :button_color do
    name  "Orange"
    value "#000000"
  end

end
