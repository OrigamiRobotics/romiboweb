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

  subject { user}

  it {should respond_to :reset_auth_token!}
  it {should respond_to :shared_palettes}

  context "should have the following atributes" do
<<<<<<< HEAD
    [:first_name, :last_name, :email, :password,
     :my_palettes, :last_viewed_palette,
     :current_palette, :set_last_viewed_palette,
     :name
    ].each do |attr|
=======
    [:first_name, :last_name, :email, :password, :auth_token].each do |attr|
>>>>>>> master
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
end
