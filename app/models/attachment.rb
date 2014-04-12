# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  attachable_id   :integer
#  attachable_type :string(255)
#

class Attachment < ActiveRecord::Base
  
  belongs_to :attachable, polymorphic: true
  
  validates_presence_of :name
  mount_uploader :name, FileUploader
end
