Rails.application.routes.draw do
  devise_for :users
  root 'users#root'
  resources :users do
    collection do
      get :root
    end
  end
  resources :posts
  resources :groups do
    resources :messages
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
end
