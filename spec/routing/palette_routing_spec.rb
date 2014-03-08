require 'spec_helper'

describe 'Routes for palettes', palette: true do
  context 'for sharing', share: true do
    it {should route(:get, 'palettes/:palette_id/share/new')
               .to controller: 'palettes/share',
                   action: 'new', palette_id: ':palette_id'}
    it {should route(:post, 'palettes/:palette_id/share')
               .to controller: 'palettes/share',
                   action: 'create', palette_id: ':palette_id'}
  end
end