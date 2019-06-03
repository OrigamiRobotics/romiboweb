# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  password               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  auth_token             :string
#  provider               :string
#  uid                    :string
#  twitter_nickname       :string
#  encryption             :string
#  encryption_key         :string
#  encryption_iv          :string
#  admin                  :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

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
