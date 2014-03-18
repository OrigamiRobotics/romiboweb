require 'spec_helper'
include Devise::TestHelpers


describe UsersController do

  def valid_attributes
    FactoryGirl.attributes_for(:user)
  end

  describe "GET dashboard when signed in" do
    before(:each) do
      @button_color ||= ButtonColor.find_or_create_by(name: "Turquoise", value: "#13c8b0")
    end

    it "assigns the signed in user" do
      user = User.create! valid_attributes
      sign_in user
      get :dashboard
      assigns(:user).should eq(user)
    end
  end

end
