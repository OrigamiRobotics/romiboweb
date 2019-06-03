# == Schema Information
#
# Table name: attachments
#
#  id              :bigint           not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachable_type :string
#  attachable_id   :bigint
#
# Indexes
#
#  index_attachments_on_attachable_type_and_attachable_id  (attachable_type,attachable_id)
#

class Attachment < ActiveRecord::Base
  
  belongs_to :attachable, polymorphic: true
  
  validates_presence_of :name
  mount_uploader :name, FileUploader
end
