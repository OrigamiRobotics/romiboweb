Romiboweb::Application.routes.draw do

  get "romiboweb_pages/home"
  get "romiboweb_pages/editor"

  root to: 'romiboweb_pages#home'

  %w[home editor].each do |page|
    get page, controller: 'romiboweb_pages', action: page
  end

  resources :users, only: [:dashboard]
  get '/dashboard'  => 'users#dashboard'           , as: :dashboard


  devise_for :users, :skip => [:sessions]

  as :user do
    get 'signin' => 'romiboweb_pages#home', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
