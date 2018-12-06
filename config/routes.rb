Rails.application.routes.draw do
  get 'guarantees/index'
  devise_for :users
  root to: 'pages#home'
  resources :users do
    resources :projects
  end
  resources :pledges
  resources :guarantees, only: :create

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
