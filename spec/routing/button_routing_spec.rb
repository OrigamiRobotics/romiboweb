require 'spec_helper'

describe 'Routing for buttons', :palette do
  it {should route(:post, '/palettes/:palette_id/buttons/:id/clone')
             .to controller: 'buttons',
                 action: 'clone',
                 palette_id: ':palette_id',
                 id: ':id'
  }
end