require 'spec_helper'

describe UsersController do

  def valid_attributes
    FactoryGirl.attributes_for(:user)
  end
  
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      assigns(:user).should be_a_new(User)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes.merge!(email: "different@email.com") }
        assigns(:user).should be_a(User)
        puts User.last.inspect
        assigns(:user).should be_persisted
      end

      it "redirects to the all city users page" do
        post :create, {:user => valid_attributes }
        response.should redirect_to root_path
      end

      it "redirects to the all users page" do
        post :create, {:user => valid_attributes }
        response.should redirect_to root_path
      end
    end
  end
end
