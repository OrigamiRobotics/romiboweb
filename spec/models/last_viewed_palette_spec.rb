# == Schema Information
#
# Table name: last_viewed_palettes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  palette_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_last_viewed_palettes_on_palette_id  (palette_id)
#  index_last_viewed_palettes_on_user_id     (user_id)
#

require 'spec_helper'

describe LastViewedPalette do
  let(:palette) { FactoryGirl.create(:last_viewed_palette)}

  subject { palette}

  context "should have the following atributes" do
    [:user, :palette].each do |attr|
      it { should respond_to attr }
    end
  end
end
