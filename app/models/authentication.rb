# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user_id    :integer
#  name       :string(255)
#  nickname   :string(255)
#  token      :text
#  email      :string(255)
#  image_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_authentications_on_user_id  (user_id)
#

class Authentication < ActiveRecord::Base
  belongs_to :user, inverse_of: :authentications
end
