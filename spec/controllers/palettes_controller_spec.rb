require 'spec_helper'

describe PalettesController, palette: true do

  let(:palette) {FactoryGirl.build :palette}

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
      expect(response).to render_template 'new'
    end
  end

  describe "POST 'create'" do
    it "returns http success" do

      post 'create', palette: palette
      expect(response.status).to eq 200
    end
  end

end
