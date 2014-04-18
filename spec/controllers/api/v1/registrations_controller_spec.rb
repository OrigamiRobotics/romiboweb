require 'spec_helper'

describe Api::V1::RegistrationsController, api: true do
  let(:user) {FactoryGirl.build(:user)}

  describe "post 'create'", auth: true do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context 'with valid attributes' do
      before :each do
        @user_attributes = FactoryGirl.attributes_for(:user)
        post :create, user: @user_attributes, format: :json
      end
      it { should respond_with 201 }
      it 'should return user attributes' do
        json = JSON.parse response.body
        json['first_name'].should eq @user_attributes[:first_name]
        json['last_name'].should eq @user_attributes[:last_name]
        json['email'].should eq @user_attributes[:email]
        json['auth_token'].should_not be_nil
      end
    end

    context 'with invalid data' do
      before :each do
        post :create, user: FactoryGirl.attributes_for(:user, email: ''), format: :json
      end

      it { should respond_with 422 }
      it 'should return error messages' do
        json = JSON.parse response.body
        json['email'].should_not be_nil
        json['email'][0].should match /can't be blank/
      end
    end

  end

end
