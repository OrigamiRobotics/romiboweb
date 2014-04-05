# == Schema Information
#
# Table name: buttons
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  speech_phrase     :string(255)
#  speech_speed_rate :float
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  button_color_id   :integer
#  size              :string(255)
#  row               :integer
#  col               :integer
#  selected          :boolean          default(FALSE)
#  palette_id        :integer
#
# Indexes
#
#  index_buttons_on_button_color_id  (button_color_id)
#  index_buttons_on_palette_id       (palette_id)
#  index_buttons_on_size             (size)
#  index_buttons_on_user_id          (user_id)
#

require 'spec_helper'

describe Button do
  let(:button) { FactoryGirl.create(:button)}
  let(:button_color) { FactoryGirl.create(:button_color)}

  subject { button}

  context "should have the following attributes" do
    [:title, :speech_phrase, :speech_speed_rate,
     :color, :user, :palettes, :button_color,
     :size, :div_id].each do |attr|
      it { should respond_to attr }
    end
  end

  it "should return correct id for div" do
    expect(button.div_id).to eql("buttonId_#{button.id}")
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

  context "should not be valid without button_color_id" do
    before { button.button_color_id = nil }
    it { should_not be_valid }
  end

  context "should not be valid when size is not one of Small, Medium, or Large" do
    before { button.size = 'Not small or medium or large' }
    it { should_not be_valid }
  end
  context "should not be valid without size" do
    before { button.size = '' }
    it { should_not be_valid }
  end
end
