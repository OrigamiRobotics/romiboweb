require 'spec_helper'
require 'omniauth'

def login_admin
  @request.env["devise.mapping"] = Devise.mappings[:admin]
  sign_in FactoryGirl.create(:admin)
end


def valid_session
  login_admin
end

OmniAuth.config.test_mode = true


describe OmniauthCallbacksController  do
  include Devise::TestHelpers

  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Turquoise", value: "#13c8b0")
  end

  describe "handle twitter authentication callback" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end

    it 'should authenticate and identify user if user is known' do
      get :twitter
      response.should be_redirect
    end
  end


  describe "handle facebook authentication callback" do
    describe "#annonymous user" do
      context "when facebook email doesn't exist in the system" do
        before(:each) do
          request.env["devise.mapping"] = Devise.mappings[:user]
          request.env["omniauth.auth"]  = OmniAuth.config.mock_auth[:facebook]
          get :facebook
          @user = User.where(:email => "johndoe@email.com").first
        end
        it { @user.should_not be_nil }
        it "should create authentication with facebook id" do
          authentication = @user.authentications.where(:provider => "facebook", :uid => "1234").first
          authentication.should_not be_nil
        end
      end
      
      context "when facebook email already exists in the system" do
        before(:each) do
          request.env["devise.mapping"] = Devise.mappings[:user]
          request.env["omniauth.auth"]  = OmniAuth.config.mock_auth[:facebook]

          User.create!(first_name: 'John',
                       last_name: 'Doe',
                       :email => "johndoe@email.com",
                       :password => "my_secret",
                       :password_confirmation => 'my_secret',
                       :confirmed_at => Time.now)
          get :facebook
        end
        
        it {   flash[:notice].should == "Authentication with Facebook successful!"}
        it {   response.should redirect_to dashboard_path }
      end
    end
  end

end
