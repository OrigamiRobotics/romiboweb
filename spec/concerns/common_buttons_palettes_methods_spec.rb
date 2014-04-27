require 'spec_helper'

include CommonButtonsPalettesMethods

describe CommonButtonsPalettesMethods do
  let(:user) {FactoryGirl.create :user}
  let(:palette) { FactoryGirl.create(:palette)}

  # def set_palette_buttons_values(speech_speed_rate, button_color, size)
  #   session[:palette_speech_speed_rate] = speech_speed_rate
  #   session[:palette_button_color]      = button_color
  #   session[:palette_size]              =  size
  # end
  #
  context "sets sessions values for palette buttons" do
    before(:each) do
      @session  = {}
    end

    it "successfully sets the values" do
      speech_speed_rate = 0.5
      button_color      = 5
      size              = "Large"
      set_palette_buttons_values speech_speed_rate, button_color, size, @session
      @session[:palette_speech_speed_rate].should == speech_speed_rate
      @session[:palette_button_color].should      == button_color
      @session[:palette_size].should              == size
    end
  end
end
