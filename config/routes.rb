Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks',
    confirmations: 'users/confirmations',
  }
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, except: :index

  namespace :admins do
    resources :users, only: [:index] do
      member do
        patch 'enable'
        patch 'disable'
      end
    end
  end

  get '/about', to: "home#about"

  namespace :profile do
    resources :posts, only: :index
    resources :users, only: [] do
      member do
        patch 'block'
        patch 'unblock'
      end
      collection do
        get 'block_list', action: :block_index
      end
    end

  end

  root to: 'home#index'
end
