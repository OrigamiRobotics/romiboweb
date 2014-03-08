require 'spec_helper'

describe LastViewedPalette do
  let(:palette) { FactoryGirl.create(:last_viewed_palette)}

  subject { palette}

  context "should have the following atributes" do
    [:user, :palette].each do |attr|
      it { should respond_to attr }
    end
  end
end
