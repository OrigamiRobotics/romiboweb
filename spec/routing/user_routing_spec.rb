require 'spec_helper'

describe 'User routes', user: true do

  context 'for language selection' do
    it {should route(:post, '/locale')
               .to(controller: 'users', action:'locale')}
  end

end