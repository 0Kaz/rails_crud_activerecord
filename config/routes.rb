Rails.application.routes.draw do
  #For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'restaurants', to: "restaurants#index"

  get 'restaurant/new', to: "restaurants#new", as: :new_restaurant
  get 'restaurants/:id', to: "restaurants#show", as: :restaurant


  get 'restaurants/:id/edit', to: 'restaurants#edit', as: :edit_restaurant
  post 'restaurants', to: "restaurants#create"
  patch 'restaurants/:id', to: 'restaurants#update'
  delete "restaurants/:id", to: "restaurants#destroy"

  # resources :restaurants

end