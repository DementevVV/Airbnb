Rails.application.routes.draw do
  root 'flow#home'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show]
  resources :rooms
  resources :photos

  resources :rooms do
    resources :reservations, only: [:create]
  end

  resources :conversations, only: [:index, :create] do 
    resources :messages, only: [:index, :create]
  end

  resources :room do
    resources :reviews, only: [:create, :destroy]
  end
  
  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'

  get '/your_trips' => 'reservations#your_trips'
  get '/your_reservations' => 'reservations#your_reservations'

end
