# == Schema Information
#
# Table name: buttons
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  color             :string(255)
#  speech_phrase     :string(255)
#  speech_speed_rate :float
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Button do
  let(:button) { FactoryGirl.create(:button)}

  subject { button}

  context "should have the following attributes" do
    [:title, :speech_phrase, :speech_speed_rate, :color, :user, :palettes].each do |attr|
      it { should respond_to attr }
    end
  end


  context "should not be valid without a title" do
    before { button.title = "" }
    it { should_not be_valid }
  end

  context "should not be valid non-numeric speech speed rate" do
    before { button.speech_speed_rate = "some value" }
    it { should_not be_valid }
  end

  context "should not be valid without user id" do
    before { button.user_id = nil }
    it { should_not be_valid }
  end
end
