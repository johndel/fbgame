Fbgame::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  match "check_name", to: "pages#check_name", via: [:get, :post]
  match "/", to: "pages#index", via: [:get, :post]
  root to: "pages#index"
  # get "/start", to: "pages#start", as: "game_start"
end
