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
# Indexes
#
#  index_button_colors_on_name_and_value  (name,value)
#

FactoryGirl.define do

  factory :button_color do
    name 'Turquoise'
    value '#000000'
  end

end
