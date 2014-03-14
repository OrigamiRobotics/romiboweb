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

require 'spec_helper'

describe PaletteViewer, palette: true do
  it {should validate_presence_of :user_id}
  it {should validate_numericality_of :user_id}

  it {should validate_presence_of :palette_id}
  it {should validate_numericality_of :palette_id}

  it {should validate_uniqueness_of(:user_id).scoped_to(:palette_id)}
end
