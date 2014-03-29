# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_name  :string(255)
#  user_id    :integer
#  avatar     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Profile do
  let(:user)    { FactoryGirl.create(:user)}
  let(:profile) { FactoryGirl.create(:profile, user: user)}

  subject {profile}

  context "has the following attributes/associations" do
    [:user_name, :avatar, :user, :slug, :name].each do |attr|
      it { should respond_to(attr)}
    end
  end

  context "when user name is already taken" do
    it "does not allow the creation of the profile" do
      expect {
        profile1 = FactoryGirl.create(:profile, user_name: profile.user_name)
      }.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: User name has already been taken")
    end
  end

end
