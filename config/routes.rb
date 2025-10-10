Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :notes
  resources :homes
  
  resources :timers do
    member do
      patch :start
      patch :pause
      patch :reset
      patch :tick
    end
  end
  
  resources :study_materials
  
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
  
  root "homes#index"  
end
