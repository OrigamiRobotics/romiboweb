require 'spec_helper'

describe PaletteViewer, palette: true do
  it {should validate_presence_of :user_id}
  it {should validate_numericality_of :user_id}

  it {should validate_presence_of :palette_id}
  it {should validate_numericality_of :palette_id}

  it {should validate_uniqueness_of(:user_id).scoped_to(:palette_id)}
end
