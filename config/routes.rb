Rails.application.routes.draw do

  get 'users/index'
  get 'users/new'
  get 'users/show'
  get 'users/create'
  get 'users/update'
  get 'users/destroy'
  root "events#index"

  resources :events
  resources :teams
  resources :contacts
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
