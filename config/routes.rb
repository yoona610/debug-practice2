Rails.application.routes.draw do
  get '/search' => 'search#search'
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
    member do
    get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
end