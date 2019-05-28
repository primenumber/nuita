Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'pages/home'
  get 'pages/about'
  get '/auth/twitter/callback', :to => 'omniauth_callbacks#twitter'
  post '/auth/twitter/callback', :to => 'omniauth_callbacks#twitter'

  resources :users, except: [:index], param: :url_digest
  resources :nweets, only: [:create, :update, :destroy]
end
