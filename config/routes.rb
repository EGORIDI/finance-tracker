Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  # get 'users/my_portfolio'
  # this route was automatically generated but we are going to use another one
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'users#search'
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
  get 'my_followers', to: 'users#my_followers'

end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
