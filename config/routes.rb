Rails.application.routes.draw do
  devise_for :users
  
  root "events#index"

  resources :users do 
    resources :avatars
  end

  resources :events do
    resources :attendances
  end

  namespace :admin do
    root "admin#index"
    resources :users, :events
  end
end
