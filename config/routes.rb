Rails.application.routes.draw do
  namespace :admin do
    get 'events/index'
    get 'events/edit'
    get 'events/update'
    get 'events/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/destroy'
  end
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
