Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'today'
    end
    member do
      post 'completed'
      get 'timer'
    end
  end
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end