# == Schema Information
#
# Table name: feedbacks
#
#  id          :integer          not null, primary key
#  statement   :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_name   :string(255)
#  user_email  :string(255)
#  page_uri    :string(255)
#

require 'spec_helper'

describe Feedback, feedback: true do

  context "should have the following attributes" do
    [:statement, :description, :user_name, :user_email, :page_uri].each do |attr|
      it { should respond_to attr }
    end
  end

  it {should validate_presence_of :user_name}
  it {should validate_presence_of :user_email}
  it {should validate_presence_of :statement}
  it {should validate_presence_of :page_uri}

end
