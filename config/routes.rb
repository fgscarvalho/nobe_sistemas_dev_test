Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resources :accounts, only: [:show, :new, :create] do
      get '/withdraw', to: 'accounts#withdraw'
      get '/deposit', to: 'accounts#deposit'
      get '/transfer', to: 'accounts#transfer'
      get '/statement', to: 'accounts#statement'
      post '/transactions/deposit', to: 'transactions#create_deposit'
      post '/transactions/withdraw', to: 'transactions#create_withdraw'
      post '/transactions/transfer', to: 'transactions#create_transfer'
      post '/close', to: 'accounts#close_account'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    root to: "devise/sessions#new"
  end
end
