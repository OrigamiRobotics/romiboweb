# Feedback represents information about reaction to RomiboWeb by User.  This will be used as a basis for improvement for RomiboWeb.
#
# a. Id: Auto generated unique identifier
# b. Statement: Single declaration or remark.
# c. Description: Descriptive statment or account using RomiboWeb.
#
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
# Indexes
#
#  index_feedbacks_on_user_id  (user_id)
#

class Feedback < ActiveRecord::Base
  attr_accessor :save_screenshot
  validates_presence_of :user_name, :user_email, :statement, :page_uri

  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates_format_of :user_email, with: VALID_EMAIL_REGEX,
  #                    message: 'must be valid'
end
