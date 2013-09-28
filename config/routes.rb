Apptest::Application.routes.draw do
  get "ajax/showform"
  get "ajax/processed"
  get "contact" => "contact#index", as: :contact
  post "contact/create", as: :post_contact
  get "index/create"
  get "home/index"
  get "home/publicfunction"
  devise_for :users
  get "sessions/new"
  get "sessions/create"
  get "sessions/failure"

  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/contacts/:importer/callback', :to => 'sessions#contacts_callback'

  get 'import/:provider', :to => 'sessions#check_authtoken'

  get "/invites" => "sessions#get_gmail_contact"
  get "/yahoo_callback" => "sessions#get_yahoo_contact"

  #match "/contacts/:importer/callback", to:  "sessions#contacts_callback", via: [:get]
  resources :contact
  root to: "home#index"
 
end
