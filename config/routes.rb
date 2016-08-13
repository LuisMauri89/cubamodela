Rails.application.routes.draw do
  
  resources :nationalities
  resources :languages
  resources :expertises
# Devise routes
  devise_for :users

# For Static Pages (like home page)		
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/contact'
  get 'static_pages/aboutus'

# Models Profile routes
  resources :profile_models

# Colors routes
  resources :colors

# Provinces routes
  resources :provinces

# Root
  root to: 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
