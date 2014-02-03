Romiboweb::Application.routes.draw do

  get "romiboweb_pages/home"
  root to: 'romiboweb_pages#home'

  %w[home].each do |page|
    get page, controller: 'romiboweb_pages', action: page
  end


end
