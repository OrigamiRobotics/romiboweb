# == Schema Information
#
# Table name: button_colors
#
#  id         :bigint           not null, primary key
#  name       :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
