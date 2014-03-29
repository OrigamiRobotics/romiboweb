# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Attachment < ActiveRecord::Base
  validates_presence_of :name
  mount_uploader :name, FileUploader
end
