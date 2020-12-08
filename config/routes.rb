Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks',
    confirmations: 'users/confirmations',
  }
  resources :posts
  resources :users, except: :index do
    member do
      patch 'enable'
      patch 'disable'
    end
  end

  namespace :admins do
    resources :users
  end

  root to: 'home#index'
end
