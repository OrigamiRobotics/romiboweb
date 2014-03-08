# == Schema Information
#
# Table name: palettes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  color       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  owner_id    :integer
#

class Palette < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :palette_buttons
  has_many :buttons, through: :palette_buttons

  has_many :palette_viewers
  has_many :viewers, class_name: 'User', through: :palette_viewers

  validates_presence_of :title

end
