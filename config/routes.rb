Rails.application.routes.draw do
  devise_for :users

  resources :answers, only: [:edit, :create, :update, :destroy]

  resources :questions do
    get 'follow'
    get 'followed', on: :collection
    get 'unfollow'
    get 'your', on: :collection
  end

  get 'users/followed', to: 'followed_users#followed', as: :users_followed
  get 'users/:id/follow', to: 'followed_users#follow', as: :users_follow
  get 'users/:id/unfollow', to: 'followed_users#unfollow', as: :users_unfollow

  root 'questions#index'
end
