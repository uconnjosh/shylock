Rails.application.routes.draw do
  resources :accounts
  resources :transactions
  resources :statements
  resources :users
end
