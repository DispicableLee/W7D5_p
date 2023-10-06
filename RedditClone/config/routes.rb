Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "sessions#new"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :index, :show, :edit, :update]
  resources :users do
    resources :subs, only: [:edit, :update, :destroy]
  end
  resources :subs, only: [:new, :create, :index]
end
