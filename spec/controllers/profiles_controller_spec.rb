require 'spec_helper'

describe ProfilesController do
  let(:user) {FactoryGirl.create :user}
  let(:profile) { FactoryGirl.create(:profile, user_id: user.id)}

  def valid_attributes
    FactoryGirl.attributes_for(:profile).merge(user_id: user.id)
  end

  def invalid_attributes
    FactoryGirl.attributes_for(:profile).merge(user_id: user.id, user_name: profile.user_name)
  end

  before :each do
    sign_in user
  end

  # describe "GET edit" do
  #   it "assigns the requested profile as profile" do
  #     get :edit, {:id => profile.to_param}
  #     assigns(:profile).should eq(profile)
  #   end
  # end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested profile" do
        fake_params = {"user_name" => 'params', "avatar" => 'avatar'}
        Profile.any_instance.should_receive(:update_attributes).with(fake_params)
        put :update, {:id => profile.id, :profile => fake_params}
      end

      it "assigns the requested profile as profile" do
        put :update, {:id => profile.to_param, :profile => valid_attributes}
        assigns(:profile).should eq(profile)
      end

      it "flashes success message" do
        put :update, {:id => profile.to_param, :profile => valid_attributes}
        flash[:success].should eq("Your profile was successfully updated.")
      end

      it "redirects to the profile" do
        put :update, {:id => profile.to_param, :profile => valid_attributes}
        response.should redirect_to(profile)
      end

      it "returns updated profile in JSON format" do
        fake_params = {:user_name => 'params2', :avatar => 'avatarx'}
        put :update, :id => profile.id, :profile => fake_params, format: :json
        response.should be_success
        response.header['Content-Type'].should match /json/
      end
    end

    describe "with invalid params" do
      it "assigns the profile as @profile" do
        profile1 = Profile.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Profile.any_instance.stub(:save).and_return(false)
        put :update, {:id => profile1.to_param, :profile => {user_name: profile1.user_name, avatar: "avatar"}}
        assigns(:profile).should eq(profile1)
      end

      # it "re-renders the 'edit' template" do
      #   profile1 = Profile.create! valid_attributes
      #   # Trigger the behavior that occurs when invalid params are submitted
      #   Profile.any_instance.stub(:save).and_return(false)
      #   put :update, {:id => profile1.to_param, :profile => {user_name: profile1.user_name, avatar: "avatar"}}
      #   response.should render_template("edit")
      # end
    end
  end

  describe "GET show" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create! valid_attributes.merge!({user_name: "new_user_name"})
      get :show, {:id => profile.id}
      assigns(:profile).should eq(profile)
    end
  end

end
