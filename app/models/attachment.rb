class Attachment < ActiveRecord::Base
  validates_presence_of :name
  mount_uploader :name, FileUploader
end
