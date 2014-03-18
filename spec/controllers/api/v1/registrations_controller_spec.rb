require 'spec_helper'

describe Api::V1::RegistrationsController, api: true do
  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Turquoise", value: "#13c8b0")
  end

  let(:user) {FactoryGirl.build(:user)}

  describe "post 'create'", auth: true do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context 'with valid attributes' do
      before :each do
        post :create, user: FactoryGirl.attributes_for(:user), format: :json
      end
      it { should respond_with 201 }
      pending { should render_template 'create' }
      it 'should return user attributes' do
        json = JSON.parse response.body
        json['first_name'].should eq user.first_name
        json['last_name'].should eq user.last_name
        json['email'].should eq user.email
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