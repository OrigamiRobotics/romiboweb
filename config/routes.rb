# == Route Map (Updated 2014-03-31 03:16)
#
#                    Prefix Verb     URI Pattern                                       Controller#Action
#      romiboweb_pages_home GET      /romiboweb_pages/home(.:format)                   romiboweb_pages#home
#    romiboweb_pages_editor GET      /romiboweb_pages/editor(.:format)                 romiboweb_pages#editor
#     romiboweb_pages_terms GET      /romiboweb_pages/terms(.:format)                  romiboweb_pages#terms
#                      root GET      /                                                 romiboweb_pages#home
#                      home GET      /home(.:format)                                   romiboweb_pages#home
#                    editor GET      /editor(.:format)                                 romiboweb_pages#editor
#                   buttons POST     /buttons(.:format)                                buttons#create
#                new_button GET      /buttons/new(.:format)                            buttons#new
#                    button GET      /buttons/:id(.:format)                            buttons#show
#                           PATCH    /buttons/:id(.:format)                            buttons#update
#                           PUT      /buttons/:id(.:format)                            buttons#update
#                           DELETE   /buttons/:id(.:format)                            buttons#destroy
#               attachments POST     /attachments(.:format)                            attachments#create
#            new_attachment GET      /attachments/new(.:format)                        attachments#new
#                  profiles POST     /profiles(.:format)                               profiles#create
#               new_profile GET      /profiles/new(.:format)                           profiles#new
#              edit_profile GET      /profiles/:id/edit(.:format)                      profiles#edit
#                   profile GET      /profiles/:id(.:format)                           profiles#show
#                           PATCH    /profiles/:id(.:format)                           profiles#update
#                           PUT      /profiles/:id(.:format)                           profiles#update
#       palette_share_index POST     /palettes/:palette_id/share(.:format)             palettes/share#create
#         new_palette_share GET      /palettes/:palette_id/share/new(.:format)         palettes/share#new
#           import_palettes POST     /palettes/import(.:format)                        palettes#import
#      grid_palette_buttons GET      /palettes/:palette_id/buttons/grid(.:format)      buttons#grid
# save_grid_palette_buttons POST     /palettes/:palette_id/buttons/save_grid(.:format) buttons#save_grid
#           palette_buttons GET      /palettes/:palette_id/buttons(.:format)           buttons#index
#                           POST     /palettes/:palette_id/buttons(.:format)           buttons#create
#        new_palette_button GET      /palettes/:palette_id/buttons/new(.:format)       buttons#new
#               edit_button GET      /buttons/:id/edit(.:format)                       buttons#edit
#                           GET      /buttons/:id(.:format)                            buttons#show
#                           PATCH    /buttons/:id(.:format)                            buttons#update
#                           PUT      /buttons/:id(.:format)                            buttons#update
#                           DELETE   /buttons/:id(.:format)                            buttons#destroy
#                  palettes GET      /palettes(.:format)                               palettes#index
#                           POST     /palettes(.:format)                               palettes#create
#               new_palette GET      /palettes/new(.:format)                           palettes#new
#              edit_palette GET      /palettes/:id/edit(.:format)                      palettes#edit
#                   palette GET      /palettes/:id(.:format)                           palettes#show
#                           PATCH    /palettes/:id(.:format)                           palettes#update
#                           PUT      /palettes/:id(.:format)                           palettes#update
#                           DELETE   /palettes/:id(.:format)                           palettes#destroy
#                   lessons POST     /lessons(.:format)                                lessons#create
#                new_lesson GET      /lessons/new(.:format)                            lessons#new
#                    lesson GET      /lessons/:id(.:format)                            lessons#show
#                 dashboard GET      /dashboard(.:format)                              users#dashboard
#                    locale POST     /locale(.:format)                                 users#locale
#   user_omniauth_authorize GET|POST /users/auth/:provider(.:format)                   omniauth_callbacks#passthru {:provider=>/twitter|facebook|google_oauth2/}
#    user_omniauth_callback GET|POST /users/auth/:action/callback(.:format)            omniauth_callbacks#(?-mix:twitter|facebook|google_oauth2)
#             user_password POST     /users/password(.:format)                         devise/passwords#create
#         new_user_password GET      /users/password/new(.:format)                     devise/passwords#new
#        edit_user_password GET      /users/password/edit(.:format)                    devise/passwords#edit
#                           PATCH    /users/password(.:format)                         devise/passwords#update
#                           PUT      /users/password(.:format)                         devise/passwords#update
#  cancel_user_registration GET      /users/cancel(.:format)                           registrations#cancel
#         user_registration POST     /users(.:format)                                  registrations#create
#     new_user_registration GET      /users/sign_up(.:format)                          registrations#new
#    edit_user_registration GET      /users/edit(.:format)                             registrations#edit
#                           PATCH    /users(.:format)                                  registrations#update
#                           PUT      /users(.:format)                                  registrations#update
#                           DELETE   /users(.:format)                                  registrations#destroy
#         user_confirmation POST     /users/confirmation(.:format)                     confirmations#create
#     new_user_confirmation GET      /users/confirmation/new(.:format)                 confirmations#new
#                           GET      /users/confirmation(.:format)                     confirmations#show
#          new_user_session GET      /signin(.:format)                                 romiboweb_pages#home
#              user_session POST     /signin(.:format)                                 devise/sessions#create
#      destroy_user_session DELETE   /signout(.:format)                                devise/sessions#destroy
#               unconfirmed GET      /unconfirmed_user(.:format)                       users#unconfirmed
#           api_v1_palettes GET      /api/v1/palettes(.:format)                        api/v1/palettes#index
#           api_v1_register POST     /api/v1/register(.:format)                        api/v1/registrations#create
#              api_v1_login POST     /api/v1/login(.:format)                           api/v1/sessions#create
#             api_v1_logout DELETE   /api/v1/logout(.:format)                          api/v1/sessions#destroy
#

Romiboweb::Application.routes.draw do

  get "romiboweb_pages/home"
  get "romiboweb_pages/editor"
	get 'romiboweb_pages/terms'

	root to: 'romiboweb_pages#home'

  %w[home editor].each do |page|
		get page, controller: 'romiboweb_pages', action: page
	end

  resources :buttons, only: [:new, :create, :show, :update, :destroy]
	resources :users, only: [:dashboard, :unconfirmed, :confirmed]
  resources :attachments, only: [:new, :create]
  resources :profiles, only: [:new, :create, :edit, :update, :show]

  resources :palettes do
    resources :share, controller: 'palettes/share', only: [:new, :create]
    collection do
      post 'import'
    end
    resources :buttons, shallow: true do
      get 'grid', on: :collection
      post 'save_grid', on: :collection
    end
  end

  resources :lessons, only: [:new, :create, :show, :index]

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
