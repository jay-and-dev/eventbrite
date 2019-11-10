Rails.application.routes.draw do
  namespace :admin do
    get 'admin/index'
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
    resources :users, :events, :event_submissions
  end
end
