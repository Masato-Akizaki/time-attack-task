Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks do
    collection do
      get 'all'
    end
    member do
      post 'completed'
      get 'timer'
    end
  end
  resources :projects
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users, :except => [:new, :create]
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end