# == Schema Information
#
# Table name: palettes
#
#  id                   :integer          not null, primary key
#  title                :string(255)
#  description          :string(255)
#  color                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  owner_id             :integer
#  system               :boolean          default(FALSE)
#  last_viewed_button   :integer
#  all_buttons_selected :boolean          default(FALSE)
#

require 'spec_helper'

describe Palette, palette: true do

  [:title, :description, :color, :buttons, :last_viewed_palette].each do |attr|
    it {should respond_to attr}
  end

  it {should validate_presence_of :title}
  it {should belong_to(:owner).class_name('User')}
  it {should have_many :palette_viewers}
  it {should have_many(:viewers).class_name('User').through(:palette_viewers)}

end
