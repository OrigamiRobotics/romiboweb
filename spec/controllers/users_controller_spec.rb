require 'spec_helper'
include Devise::TestHelpers


describe UsersController do

  def valid_attributes
    FactoryGirl.attributes_for(:user)
  end

  describe "GET dashboard when signed in" do
    it "assigns the signed in user" do
      user = User.create! valid_attributes
      sign_in user
      get :dashboard
      assigns(:user).should eq(user)
    end


  end

  #describe "GET dashboard when NOT signed in" do
  #  it "redirects to sign in/sign up page" do
  #    user = User.new
  #    sign_in user
  #    get :dashboard
  #    expect(response.status).to eq(200)
  #  end
  #end





  #describe "POST create" do
  #  describe "with valid params" do
  #    it "creates a new User" do
  #      expect {
  #        post :create, {:user => valid_attributes }
  #      }.to change(User, :count).by(1)
  #    end
  #
  #    it "assigns a newly created user as @user" do
  #      post :create, {:user => valid_attributes.merge!(email: "different@email.com") }
  #      assigns(:user).should be_a(User)
  #      puts User.last.inspect
  #      assigns(:user).should be_persisted
  #    end
  #
  #    it "redirects to the all city users page" do
  #      post :create, {:user => valid_attributes }
  #      response.should redirect_to root_path
  #    end
  #
  #    it "redirects to the all users page" do
  #      post :create, {:user => valid_attributes }
  #      response.should redirect_to root_path
  #    end
  #  end
  #end
end
