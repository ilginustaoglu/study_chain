Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  # Email verification with code (disabled for now)
  # get 'verify', to: 'verifications#new', as: 'new_verification'
  # post 'verify', to: 'verifications#verify', as: 'verify'
  # post 'verify/resend', to: 'verifications#resend', as: 'resend_verification'
  
  # Admin routes
  namespace :admin do
    get '/', to: 'admin#index', as: 'dashboard'
    get 'users', to: 'admin#users'
    patch 'users/:id/role', to: 'admin#update_user_role', as: 'update_user_role'
    delete 'users/:id', to: 'admin#delete_user', as: 'delete_user'
    post 'users/:id/force_logout', to: 'admin#force_logout_user', as: 'force_logout_user'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :notes
  resources :tasks do
    member do
      patch :toggle
    end
  end
  resources :homes
  
  resources :timers do
    member do
      patch :start
      patch :pause
      patch :reset
      patch :tick
    end
  end
  
  resources :study_materials do
    member do
      delete :remove_file
    end
  end
  
  resources :flashcard_collections do
    member do
      post :add_card
      delete :remove_card
    end
  end
  
  resources :agendas
  
  resources :reminders do
    member do
      patch :toggle_alarm
    end
  end
  
  # Landing page for non-authenticated users
  get 'landing', to: 'landing#index', as: 'landing'
  
  # Root path - redirect based on authentication
  authenticated :user do
    root 'homes#index', as: :authenticated_root
  end
  
  root 'landing#index'
end
