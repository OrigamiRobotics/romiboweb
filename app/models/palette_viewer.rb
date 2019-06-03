# == Schema Information
#
# Table name: palette_viewers
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  palette_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_palette_viewers_on_palette_id  (palette_id)
#  index_palette_viewers_on_user_id     (user_id)
#

class PaletteViewer < ActiveRecord::Base
  belongs_to :user
  belongs_to :palette

  validates_presence_of :user_id, :palette_id
  validates_numericality_of :user_id, :palette_id
  validates_uniqueness_of :user_id, scope: :palette_id
end
