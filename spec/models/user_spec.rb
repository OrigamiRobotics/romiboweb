# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  password               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  auth_token             :string(255)
#

require 'spec_helper'


describe User, user: true, auth: true do
  let(:user) { FactoryGirl.create(:user)}

  before(:each) do
    @attr ||= FactoryGirl.attributes_for(:user)
  end

  subject { user}

  it {should respond_to :reset_auth_token!}

  context "should have the following atributes" do
    [:first_name, :last_name, :email, :password,
     :my_palettes, :last_viewed_palette,
     :current_palette, :set_last_viewed_palette,
     :name, :authentications
    ].each do |attr|
      it { should respond_to attr }
    end
  end

  describe "creating a new user" do
    context "with invalid params" do
      describe "when first name is not present" do
        before { user.first_name = "" }
        it { should_not be_valid }
      end

      describe "when last name is not present" do
        before { user.last_name = "" }
        it { should_not be_valid }
      end

      describe "when email is not present" do
        before { user.email = "" }
        it { should_not be_valid }
      end
    end

    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
              foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user.email = invalid_address
          user.should_not be_valid
        end
      end
    end

    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          user.email = valid_address
          user.should be_valid
        end
      end
    end

    describe "when email is taken" do
      let(:dup_user) {user.dup}

      subject {dup_user}

      it {should_not be_valid}
    end
  end

  describe "apply_omniauth method" do
    before(:each) do
      @user = User.new(@attr)
      #request.env["devise.mapping"] = Devise.mappings[:user]
      omniauth = OmniAuth.config.mock_auth[:twitter]
      @user.apply_omniauth omniauth
    end

    it "should have supplied provider" do
      @user.provider.should be == 'twitter'
    end

    it "should have the supplied uid" do
      @user.uid.should be == '123545'
    end

  end

  describe "add_athentication method" do
    before(:each) do

      hash = @attr.merge(provider: "twitter", uid: '1234')
      @user = User.create!(@attr)

      #add facebook provider
      Authentication.create!(provider: 'facebook', uid: '12345', user_id: 101)
    end


    it "should have no authentications yet" do
      @user.authentications.count.should be == 0
    end

    context "with no matching existing provider" do
      it "should have provider id matching what was supplied" do
        @user.provider = 'twitter'
        @user.uid      = '1234'
        expect {
          @user.add_authentication OmniAuth.config.mock_auth[:twitter]
        }.to change { @user.authentications.count }.by(1)
      end

    end

    context "with matching existing provider" do
      before(:each) do
        #add user with twitter authentication
        Authentication.create!(provider: 'twitter', uid: '1234', user_id: 100)
      end
      it "should result in its authentications incremented by 1" do
        @user.provider = 'twitter'
        @user.uid      = '1234'
        expect {
          @user.add_authentication OmniAuth.config.mock_auth[:twitter]
        }.to change { @user.authentications.count }.by(1)
      end
    end

    describe "from_twitter_oauth method" do
      before(:each) do
        #create twitter user
        hash = @attr.merge(twitter_nickname: 'first', email: 'firstemail@example.com')
        @user = User.create!(hash)

        #create facebook user
        hash = @attr.merge(twitter_nickname: 'second', email: 'secondemail@example.com')
        @user2 = User.create!(hash)

        omniauth = OmniAuth.config.mock_auth[:twitter]
        @user = User.from_twitter_oauth omniauth

      end

      context "with no twitter authentication available" do
        context 'find using valid auth without email' do
          it 'should create a valid user' do
            @user.should_not be_valid
          end

          it 'should have same provider as omniauth' do
            @user.provider.should be == 'twitter'
          end

          it 'should have same uid as omniauth' do
            @user.uid.should be == '123545'
          end

          it "'s number of authentications should be 0" do
            @user.authentications.count.should be(0)
          end
        end

        context 'find using valid auth with email' do
          before(:each) do
            @user.email = "dreader@example.com"
            @user.password = "password1234"
            @user.password_confirmation = "password1234"
            @user.save
          end
          it 'should create a valid user' do
            @user.should be_valid
          end

          it 'should have same provider as omniauth' do
            @user.provider.should be == 'twitter'
          end

          it 'should have same uid as omniauth' do
            @user.uid.should be == '123545'
          end
        end
      end

      context 'with twitter authentication available' do
        before(:each) {
          @user.provider = 'twitter'
          @user.uid = '123544'
          @user.twitter_nickname = 'ruff4life'
          @omniauth = OmniAuth.config.mock_auth[:twitter]
          @user.add_authentication @omniauth
          @user = User.from_twitter_oauth @omniauth
        }

        context 'find using valid auth' do
          it 'should find a user with matching provider' do
            @user.provider.should be == 'twitter'
          end

          it 'should find a user with matching uid' do
            @user.uid.should be == '123545'
          end

          it "should not create a new authentication" do
            expect {
              @user = User.from_twitter_oauth @omniauth
            }.to change{@user.authentications.count}.by(0)
          end
        end

      end
    end

    describe "from_facebook_oauth method" do
      before(:each) do
        #create twitter user
        hash = @attr.merge(twitter_nickname: 'first', email: Faker::Internet.email)
        @user = User.create!(hash)

        #create facebook user
        hash = @attr.merge(twitter_nickname: 'second', email: 'secondemail@example.com')
        @user2 = User.create!(hash)

        omniauth = OmniAuth.config.mock_auth[:facebook]
        @user = User.from_facebook_oauth omniauth
      end

      context "with no facebook authentication available" do
        context 'find using valid auth' do
          it 'should create a valid user' do
            @user.should be_valid
          end

          it 'should have same provider as omniauth' do
            @user.provider.should be == 'facebook'
          end

          it 'should have same uid as omniauth' do
            @user.uid.should be == '1234'
          end

          it "'s number of authentications should be 1" do
            @user.authentications.count.should be(1)
          end
        end
      end


      context 'with facebook authentication available' do
        before(:each) {
          @user.provider = 'facebook'
          @user.uid = '1234'
          @user.email = 'johndoe@email.com'
          @omniauth = OmniAuth.config.mock_auth[:facebook]
          @user.add_authentication @omniauth
          @user = User.from_facebook_oauth @omniauth
        }

        context 'find using valid auth' do
          it 'should find a user with matching provider' do
            @user.provider.should be == 'facebook'
          end

          it 'should find a user with matching uid' do
            @user.uid.should be == '1234'
          end

          it "should not create a new authentication" do
            expect {
              @user = User.from_facebook_oauth @omniauth
            }.to change{@user.authentications.count}.by(0)
          end
        end
      end

    end

    describe "get_user_by_oauth method" do
      before(:each) do
        #create twitter user
        hash = @attr.merge(twitter_nickname: 'first', email: Faker::Internet.email)
        @user = User.create!(hash)

        #create facebook user
        hash = @attr.merge(twitter_nickname: 'second', email: 'secondemail@example.com')
        @user2 = User.create!(hash)

        @test_user = @user

      end

      context 'with no authentications available' do
        before(:each) {
          omniauth = OmniAuth.config.mock_auth[:twitter]
          @user = User.get_user_by_oauth omniauth
        }

        it 'should not find a matching user' do
          @user.should be_nil
        end
      end

      context 'with twitter authentication available' do
        before(:each) {
          @user.provider = 'twitter'
          @user.uid = '123545'
          @user.twitter_nickname = 'ruff4life'
          omniauth = OmniAuth.config.mock_auth[:twitter]
          @user.add_authentication omniauth
          @user = User.get_user_by_oauth omniauth
        }

        context 'find using valid auth' do
          it 'should find a matching user' do
            @user.should be_valid
          end
        end

        context 'find using invalid auth' do
          before (:each) do
            omniauth = OmniAuth.config.mock_auth[:fakesocialmedia]
            @user = User.get_user_by_oauth omniauth
          end
          it 'should NOT find a matching user' do
            @user.should be_nil
          end
        end

      end


      context 'with facebook authentication available' do
        before(:each) {
          @user = @test_user
          @user.provider = 'facebook'
          @user.uid = '1234'
          @user.email = 'johndoe@email.com'
          omniauth = OmniAuth.config.mock_auth[:facebook]
          @user.add_authentication omniauth
          @user = User.get_user_by_oauth omniauth
        }

        context 'find using valid auth' do
          it 'should find a matching user' do
            @user.should_not be_nil
          end
        end


        context 'find using invalid auth' do
          before (:each) do
            omniauth = OmniAuth.config.mock_auth[:fakesocialmedia]
            @user = User.get_user_by_oauth omniauth
          end
          it 'should NOT find a matching user' do
            @user.should be_nil
          end
        end
      end

      context 'with linkedin authentication available' do
        before(:each) {
          @user.provider = 'linkedin'
          @user.uid = '12345'
          @user.email = 'johndoelinked@email.com'
          omniauth = OmniAuth.config.mock_auth[:linkedin]
          @user.add_authentication omniauth
          @user = User.get_user_by_oauth omniauth
        }

        context 'find using valid auth' do
          it 'should find a matching user' do
            @user.should be_valid
          end
        end

        context 'find using invalid auth' do
          before (:each) do
            omniauth = OmniAuth.config.mock_auth[:fakesocialmedia]
            @user = User.get_user_by_oauth omniauth
          end
          it 'should NOT find a matching user' do
            @user.should be_nil
          end
        end
      end
    end

    describe "from_omniauth method" do
      describe 'exising user attempts to sign in with twitter' do
        before(:each) do
          @user = User.new(@attr.merge(email: Faker::Internet.email))
          omniauth = OmniAuth.config.mock_auth[:twitter]
          @user.apply_omniauth omniauth
        end
      end

      describe 'new user attempts to sign in through social media' do
        before(:each) do
          hash = @attr.merge(provider: "Ruff", uid: 'ruff4life', email: Faker::Internet.email)
          @user = User.new(hash)
        end

        context 'signing using twitter, no email' do

        end
        it "should persists in the database" do
          @user.should be_valid
        end

        it 'should have a new provider' do
          @user.provider.should be == 'Ruff'
        end

        it 'should have a new uid' do
          @user.uid.should be == 'ruff4life'
        end
      end
    end
  end
end
