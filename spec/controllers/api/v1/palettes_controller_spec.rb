require 'spec_helper'

describe Api::V1::PalettesController, palette: true, api: true do

  describe "get 'index'" do
    before :each do
      get :index, format: :json
    end

    it { should respond_with 200 }
    it { should render_template 'index' }
  end
end