Rails.application.routes.draw do
  root 'static_pages#home'
  get 'sessions/new'
  resources :tasks do
    collection do
      get 'all'
      get 'no_project'
      get 'done'
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
  post 'guest_login', to: "guest_sessions#create"
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  get '*path', controller: 'application', action: 'render_404'
end