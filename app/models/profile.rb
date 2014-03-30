# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_name  :string(255)
#  user_id    :integer
#  avatar     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  validates :user_name, uniqueness: true, allow_blank: true

  belongs_to :user, inverse_of: :profile

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  mount_uploader :avatar, AvatarUploader

  after_update :crop_avatar

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def name
    user.full_name
  end

  def get_avatar_url(size)
    (self.avatar_url.present?) ? self.avatar_url(size).to_s  :  nil
  end

  def email
    user.email
  end
end
