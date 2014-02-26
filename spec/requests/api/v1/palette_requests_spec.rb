require 'spec_helper'

describe 'API request', palette: true, api: true do

  subject {response}

  let(:palettes) {FactoryGirl.create_list(:palette, 5)}

  describe 'for list of palettes' do
    before :each do
      get 'api/v1/palettes', format: :json
    end

    it {should be_success}

    it 'should list all palettes' do
      FactoryGirl.create_list(:palette, 5)
      get 'api/v1/palettes', format: :json
      json = JSON.parse response.body
      expect(json.length).to eq(5)
    end


  end
end