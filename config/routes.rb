Rails.application.routes.draw do
  root 'flow#home'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show]
  resources :rooms
  resources :photos

  resources :rooms do
    resources :reservations, only: [:create]
  end
  
end
