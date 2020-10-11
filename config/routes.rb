Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end