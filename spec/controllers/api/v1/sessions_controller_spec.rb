require 'spec_helper'

describe Api::V1::SessionsController, api: true do

  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Orange", value: "#d45300")
  end

  let(:user) {FactoryGirl.create :user}

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST '/api/v1/login'", auth: true do

    context 'with valid user credentials' do
      before {post :create,
                   email: user.email, password: user.password,
                   format: :json}

      it {should respond_with 201}
      it 'should return user attributes' do
        json = JSON.parse response.body
        json['first_name'].should eq user.first_name
        json['last_name'].should eq user.last_name
        json['email'].should eq user.email
        json['auth_token'].should_not be_nil
      end
    end

    context 'with invalid user credentials' do
      before {post :create,
                   email: user.email,
                   password: 'booboo',
                   format: :json}

      it {should respond_with 401}
    end

  end

  describe "DELETE '/api/v1/logout'", auth: true do
    context 'with valid auth token' do
      before do
        @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token)
        delete :destroy, format: :json
      end

      it {should respond_with 204}
      it 'should invalidate user auth_token' do
        old_token = user.auth_token
        new_token = user.reload.auth_token
        new_token.should_not eq old_token
      end
    end

    context 'without valid auth token' do
      before {delete :destroy, format: :json}

      it {should respond_with 401}
    end
  end

end
