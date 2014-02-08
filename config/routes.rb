Romiboweb::Application.routes.draw do


  devise_for :users

  get "romiboweb_pages/home"

  root to: 'romiboweb_pages#home'

  %w[home].each do |page|
    get page, controller: 'romiboweb_pages', action: page
  end

  resources :users

end
