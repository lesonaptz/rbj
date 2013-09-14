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
  
  resources :contact
  root to: "home#index"
 
end
