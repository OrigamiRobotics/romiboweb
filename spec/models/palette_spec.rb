require 'spec_helper'

describe Palette, palette: true do

  [:title, :description, :color, :buttons].each do |attr|
    it {should respond_to attr}
  end

  it {should validate_presence_of :title}
  it {should belong_to(:owner).class_name('User')}

end
