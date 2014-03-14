# == Schema Information
#
# Table name: palette_viewers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  palette_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class PaletteViewer < ActiveRecord::Base
  belongs_to :user
  belongs_to :palette

  validates_presence_of :user_id, :palette_id
  validates_numericality_of :user_id, :palette_id
  validates_uniqueness_of :user_id, scope: :palette_id
end
