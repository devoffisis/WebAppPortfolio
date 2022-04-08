Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get "/users/:id", to: "users#show", as: "user"
  resources :posts, only: [:index, :new, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy]
  # TODO get "/users/:id", to: "users#show", as: "user" の形式で適切に follows を指定する
  resources :users do
    resource :follows, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end
end
