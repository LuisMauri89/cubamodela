Rails.application.routes.draw do

# Devise routes
  devise_for :users

# For Static Pages (like home page)		
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/contact'
  get 'static_pages/aboutus'

# Model Profile routes
  resources :profile_model

# Root
  root to: 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
