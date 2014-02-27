require 'spec_helper'

describe 'API Routing', api: true do

  context 'for palettes', palette: true do
    it {should route(:get, '/api/v1/palettes')
               .to(controller: 'api/v1/palettes', action:'index')}
  end

  context 'for registration and login', auth: true do
    it {should route(:post, '/api/v1/register')
               .to(controller: 'api/v1/registrations',
                   action:'create')}
  end

end