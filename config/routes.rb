Rails.application.routes.draw do
  get "/favorites", to: "pages#favorite_recipes", as: "favorites"

  resources :recipes do
    put :favorite, on: :member
  end
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
