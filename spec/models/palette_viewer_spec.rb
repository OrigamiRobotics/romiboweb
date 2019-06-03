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

require 'spec_helper'

describe PaletteViewer, palette: true do
  it {should validate_presence_of :user_id}
  it {should validate_numericality_of :user_id}

  it {should validate_presence_of :palette_id}
  it {should validate_numericality_of :palette_id}

  it {should validate_uniqueness_of(:user_id).scoped_to(:palette_id)}
end
