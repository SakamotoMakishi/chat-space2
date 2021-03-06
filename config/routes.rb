Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'users#root'
  resources :users do
    collection do
      get :root
      get :test_user_notify
      get :like_show
      get :test
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :posts do
    collection do
      post :upload_image
    end
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :groups do
    resources :messages
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
  post   '/like/:post_id' => 'likes#like',   as: 'like'
  delete '/like/:post_id' => 'likes#unlike', as: 'unlike'
  post   '/retweet/:post_id' => 'retweets#retweet',   as: 'retweet'
  delete '/retweet/:post_id' => 'retweets#unretweet', as: 'unretweet'
end
