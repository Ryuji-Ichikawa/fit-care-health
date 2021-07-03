Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords:     'users/passwords'
  }
  root to: 'posts#index'

  # 投稿のルーティング
  resources :posts do
    resources :comments, only: :create
    collection do
      get 'search'
    end
    post 'likes' => "likes#create"
    delete 'likes' => "likes#destroy"
  end

  # タグのルーティング
  resources :tags do
    get 'posts', to: 'posts#search'
  end
  
  # ユーザーのルーティング
  resources :users, only: [:show, :edit, :update]
  resources :users do
    member do
        get :following, :followers
    end
  end
  resources :follows, only: [:create, :destroy]
  # ゲスト機能のルーティング
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
