class PaletteViewer < ActiveRecord::Base
  belongs_to :user
  belongs_to :palette

  validates_presence_of :user_id, :palette_id
  validates_numericality_of :user_id, :palette_id
  validates_uniqueness_of :user_id, scope: :palette_id
end
