Rails.application.routes.draw do
  get "/", to: "home#index"
  get "/welcome", to: "welcome#index"
  resources :users
  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :session
  delete "/signout" => "sessions#destroy", as: :destroy_session
  # get "/restaurants/{restaurant.id}/fooditems", controller: "restaurants", action: "hellow"
  get '/users/{user.id}', controller: "users", action: "show"
  resources :fooditems
  resources :restaurants do 
    resources :fooditems
  end

end
