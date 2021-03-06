require 'spec_helper'

describe 'Routing for lessons', lesson: true do

  it {should route(:get, '/lessons/new')
             .to(controller: 'lessons',
                 action:'new')}
  it {should route(:post, '/lessons')
             .to(controller: 'lessons',
                 action:'create')}
  it {should route(:get, '/lessons')
             .to(controller: 'lessons',
                 action:'index')}
  it {should route(:get, '/lessons/:id/edit')
             .to(controller: 'lessons',
                 id: ':id',
                 action:'edit')}
  it {should route(:put, '/lessons/:id')
             .to(controller: 'lessons',
                 id: ':id',
                 action:'update')}
  it {should route(:delete, '/lessons/:id')
             .to(controller: 'lessons',
                 id: ':id',
                 action:'destroy')}

end
