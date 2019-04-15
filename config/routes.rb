Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'pages/home'
  get 'pages/about'

  resources :users
  resources :nweets, only: [:show, :create, :destroy]
end
