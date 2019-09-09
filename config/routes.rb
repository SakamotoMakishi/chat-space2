Rails.application.routes.draw do
  devise_for :users
  root 'users#root'
  resources :users do
    collection do
      get :root
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts do
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
end
