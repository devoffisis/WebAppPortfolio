Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get "/users/:id", to: "users#show", as: "user"
  resources :posts, only: [:index, :new, :create, :destroy]
  resources :likes, only: [:create, :destroy]
end
