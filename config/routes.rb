Romiboweb::Application.routes.draw do


  get "feedbacks/new"
  get "feedbacks/index"
  get "romiboweb_pages/home"
  get "romiboweb_pages/editor"
	get "romiboweb_pages/home"

	root to: 'romiboweb_pages#home'

  %w[home editor].each do |page|
		get page, controller: 'romiboweb_pages', action: page
	end

  resources :feedbacks, only: [:new, :create, :index]
  resources :buttons, only: [:new, :create, :show, :update, :destroy]
	resources :users, only: [:dashboard]
  resources :palettes do
    collection do
      post 'import'
    end
  end
	get '/dashboard'  => 'users#dashboard', as: :dashboard


	devise_for :users, :skip => [:sessions], controllers: { registrations: "registrations"}

	as :user do
		get 'signin' => 'romiboweb_pages#home', :as => :new_user_session
		post 'signin' => 'devise/sessions#create', :as => :user_session
		delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
	end

end
