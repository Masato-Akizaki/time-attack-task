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
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end