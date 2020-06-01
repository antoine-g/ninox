Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users

  get '/documents/most_viewed', to: 'documents#most_viewed'
  resources :documents

  resources :courses

  resources :users

  get "pages/home"

  get "pages/about"

  root to: 'pages#home'
end
