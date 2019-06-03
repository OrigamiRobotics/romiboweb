class AddAttachableReferenceToAttachments < ActiveRecord::Migration[5.2]
  def change
    add_reference :attachments, :attachable, polymorphic: true 
  end
end
