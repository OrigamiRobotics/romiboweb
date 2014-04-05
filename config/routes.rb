Romiboweb::Application.routes.draw do

  get "feedbacks/new"
  get "feedbacks/index"
  get "romiboweb_pages/home"
  get "romiboweb_pages/editor"
	get 'romiboweb_pages/terms'

	root to: 'romiboweb_pages#home'

  %w[home editor].each do |page|
		get page, controller: 'romiboweb_pages', action: page
	end

  resources :feedbacks, only: [:new, :create, :index]
  resources :buttons, only: [:new, :create, :show, :update, :destroy]
	resources :users, only: [:dashboard, :unconfirmed, :confirmed]
  resources :attachments, only: [:new, :create]
  resources :profiles, only: [:new, :create, :edit, :update, :show]

  resources :palettes do
    resources :share, controller: 'palettes/share', only: [:new, :create]
    collection do
      post 'import'
    end
    resources :buttons do
      get 'grid', on: :collection
      post 'save_grid', on: :collection
      post 'clone', on: :member
    end
  end

	get '/dashboard'  => 'users#dashboard', as: :dashboard
  post '/locale' => 'users#locale'


  devise_for :users, :skip => [:sessions],
             controllers: {registrations: 'registrations',
                           omniauth_callbacks: "omniauth_callbacks",
                           confirmations: 'confirmations'
             }

  #resources :passwords

	as :user do
		get 'signin'            => 'romiboweb_pages#home', :as => :new_user_session
		post 'signin'           => 'devise/sessions#create', :as => :user_session
		delete 'signout'        => 'devise/sessions#destroy', :as => :destroy_user_session
    get '/unconfirmed_user' => 'users#unconfirmed', as: :unconfirmed
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
