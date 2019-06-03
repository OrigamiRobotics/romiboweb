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

require 'spec_helper'

describe ButtonColor do
  let(:color) { FactoryGirl.create(:button_color)}

  subject { color}

  context "should have the following attributes" do
    [:name, :value, :buttons].each do |attr|
      it { should respond_to attr }
    end
  end


  context "should not be valid without a name" do
    before { color.name = "" }
    it { should_not be_valid }
  end

  context "should not be valid without a value" do
    before { color.value = "" }
    it { should_not be_valid }
  end

  context "should not be valid non-hex value" do
    before { color.value = "somevalue" }
    it { should_not be_valid }
  end
end
