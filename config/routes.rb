Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static#root'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'register', to: 'users#new'

  get 'ui', controller: 'ui', action: 'index'
  %w(test).each do |action|
    get "ui/#{action}", controller: 'ui', action: action
  end
  
  resources :reviews, only: [:new, :create]
  
  resources :businesses, except: [:destroy] do
    resources :reviews, only: [:create]
  end
  resources :users, except: [:destroy]
end
