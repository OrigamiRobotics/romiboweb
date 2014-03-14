# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  email      :string(255)
#

require 'spec_helper'

describe Feedback do
  let(:feedback) { FactoryGirl.create(:feedback)}

  subject { feedback}

  context "should have the following attributes" do
    [:title, :content, :user, :made_by].each do |attr|
      it { should respond_to attr }
    end
  end

  context "should not be valid without a title" do
    before { feedback.title = "" }
    it { should_not be_valid }
  end

  context "should not be valid without content" do
    before { feedback.content = "" }
    it { should_not be_valid }
  end

  context "should not be valid without user" do
    before { feedback.user_id = nil }
    it { should_not be_valid }
  end

end
