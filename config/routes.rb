Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :accounts, only: [:show, :new, :create] do
      get '/withdraw', to: 'accounts#withdraw'
      get '/deposit', to: 'accounts#deposit'
      post '/transactions/deposit', to: 'transactions#create_deposit'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    root to: "devise/sessions#new"
  end
end
