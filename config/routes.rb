Rails.application.routes.draw do
  # get 'users/my_portfolio'
  # this route was automatically generated but we are going to use another one
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'

end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
