require 'spec_helper'

describe Api::V1::PalettesController, api: true do

  let!(:user) {FactoryGirl.create :user}
  let!(:palettes) {FactoryGirl.create_list :palette, 5, owner_id: user.id}

  describe "GET 'index'", palette: true do

    context 'without valid auth_token', auth: true do
      before {get :index, format: :json}
      it { should respond_with 401 }
    end

    context 'with valid auth_token' do
      render_views
      before :each do
        @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token)
        get :index, format: :json
      end

      it { should respond_with 200 }
      it { should render_template 'index' }

      it 'should only return palettes visible to user' do
        json = JSON.parse response.body
        json['palettes'].length.should eq 5
        json['palettes'].each do |palette|
          palette['palette']['owner_id'].should eq user.id
        end
      end
    end

  end
end