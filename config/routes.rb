Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'pages/home'
  get '/i/notifications', :to=> 'pages#notifications', as: 'notifications'
  get 'pages/about'
  get '/auth/twitter/callback', :to => 'twitters#create'
  post '/auth/twitter/callback', :to => 'twitters#create'
  delete '/auth/twitter', :to => 'twitters#destroy'

  resources :users, except: [:index], param: :url_digest do
    member do
      get :likes
      get :followers, :followees
    end
  end

  resources :nweets, only: [:create, :update, :destroy, :show], param: :url_digest
  resource :category, only: [:create, :destroy]
  resource :favorite, only: [:create, :destroy]
  resource :link, only: [:create]
  resource :relationship, only: [:create, :destroy]
end
