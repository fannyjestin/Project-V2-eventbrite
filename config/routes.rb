Rails.application.routes.draw do

  root "events#index"
  devise_for :users
  resources :events do 
  	  resources :charges
      resources :attendances
      resources :avatars
  end 
  
  resources :teams
  resources :contacts
  #resources :users do
   # resources :avatars
  #end
  resources :user, :has_one => [:avatar]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
