Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'pages/home'
  get 'pages/about'
  get '/auth/twitter/callback', :to => 'twitters#create'
  post '/auth/twitter/callback', :to => 'twitters#create'
  delete '/auth/twitter', :to => 'twitters#destroy'

  resources :users, except: [:index], param: :url_digest
  resources :nweets, only: [:create, :update, :destroy, :show]
end
