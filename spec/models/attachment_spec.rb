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

require 'spec_helper'

describe Attachment do
  pending "add some examples to (or delete) #{__FILE__}"
end
