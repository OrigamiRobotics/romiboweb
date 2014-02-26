require 'spec_helper'

describe 'Routing for API', palette: true do

  it {should route(:get, '/api/v1/palettes')
             .to(controller: 'api/v1/palettes', action:'index')}

end