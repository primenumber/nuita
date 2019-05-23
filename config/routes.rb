Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'pages/home'
  get 'pages/about'

  resources :users, except: [:index], param: :url_digest
  resources :nweets, only: [:create, :update, :destroy]
end
