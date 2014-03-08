Romiboweb::Application.routes.draw do


  get "romiboweb_pages/home"
  get "romiboweb_pages/editor"
	get "romiboweb_pages/home"
	root to: 'romiboweb_pages#home'

  %w[home editor].each do |page|
		get page, controller: 'romiboweb_pages', action: page
	end

  resources :buttons, only: [:new, :create, :show, :update, :destroy]
	resources :users, only: [:dashboard]
  resources :palettes
	get '/dashboard'  => 'users#dashboard', as: :dashboard
  post '/locale' => 'users#locale'


	devise_for :users, :skip => [:sessions, :passwords], controllers:
      {registrations: 'registrations'}

	as :user do
		get 'signin' => 'romiboweb_pages#home', :as => :new_user_session
		post 'signin' => 'devise/sessions#create', :as => :user_session
		delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  ######### API routes ##########

  namespace :api do
    namespace :v1 do
      resources :palettes, only: [:index]
      as :user do
        post 'register' => 'registrations#create'
        post 'login' => 'sessions#create'
        delete 'logout' => 'sessions#destroy'
      end

    end
  end

end
