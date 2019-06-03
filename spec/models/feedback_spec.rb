# == Schema Information
#
# Table name: feedbacks
#
#  id          :bigint           not null, primary key
#  statement   :string
#  description :text
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_name   :string
#  user_email  :string
#  page_uri    :string
#
# Indexes
#
#  index_feedbacks_on_user_id  (user_id)
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
