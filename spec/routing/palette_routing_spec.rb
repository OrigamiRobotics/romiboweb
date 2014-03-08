require 'spec_helper'

describe 'Routes for palettes', palette: true do
  context 'for sharing' do
    it {should route(:post, 'palettes/:id/share')
               .to controller: 'palettes', action: 'share', id: ':id'}
  end
end