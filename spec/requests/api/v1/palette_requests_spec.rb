require 'spec_helper'

describe 'API call', palette: true, api: true do

  subject {response}

  let(:palettes) {FactoryGirl.create_list(:palette, 5)}

  describe 'getting list of palettes' do
    @palettes = FactoryGirl.create_list(:palette, 5)

    before :each do
      get 'api/v1/palettes', format: :json
    end

    it {should be_success}

    it 'should list all palettes' do
      get 'api/v1/palettes', format: :json
      json = JSON.parse response.body
      expect(json.length).to eq(5)
    end


  end
end