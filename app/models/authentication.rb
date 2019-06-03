# == Schema Information
#
# Table name: authentications
#
#  id         :bigint           not null, primary key
#  provider   :string
#  uid        :string
#  user_id    :bigint
#  name       :string
#  nickname   :string
#  token      :text
#  email      :string
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_authentications_on_user_id  (user_id)
#

class Authentication < ActiveRecord::Base
  belongs_to :user, inverse_of: :authentications
end
