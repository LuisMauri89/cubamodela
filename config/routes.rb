Rails.application.routes.draw do

  resources :modalities
# For internationalization
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

# Devise routes
  devise_for :users, :path => 'account'

# Users routes
  resources :users, only: [:index]

# For Static Pages (like home page)		
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/contact'
  get 'static_pages/aboutus'

# Models Profile routes
  resources :profile_models do
    get 'show_resume', on: :member
  end

# Photographers Profile routes
  resources :profile_photographers do
    get 'show_resume', on: :member
  end

# Colors routes
  resources :colors

# Provinces routes
  resources :provinces

# Languages routes
  resources :languages

# Expertises routes
  resources :expertises

# Nationalities routes
  resources :nationalities

# Photos concern
  concern :attachable do
    resources :photos do
      get 'uploaded', on: :member
    end
  end 

# Albums routes
  resources :albums do
    concerns :attachable
    get 'delete', on: :member
  end

# Studies routes
  resources :studies

# Messages routes
  resources :messages do
    get '/read_all/', to: 'messages#read_all', as: :read_all, on: :collection
    get '/unread_all/', to: 'messages#unread_all', as: :unread_all, on: :collection
  end

# Castings routes
resources :castings do
  get 'edit_photos', on: :member
  concerns :attachable
  get 'manage', on: :member
  get 'close', on: :member
  get 'cancel', on: :member
  get 'activate', on: :member
  get '/custom/index/:profile_id', to: 'castings#index_custom', as: :custom_index, on: :collection
  get '/custom/index/invite/:profile_id', to: 'castings#index_custom_invite', as: :custom_index_invite, on: :collection
  get '/invite/index/', to: 'castings#index_invite', on: :member
  get '/invited/index/', to: 'castings#index_invited', on: :member
  get '/confirmed/index/', to: 'castings#index_confirmed', on: :member
  get '/favorites/index/', to: 'castings#index_favorites', on: :member
  get '/applied/index/', to: 'castings#index_applied', on: :member
  get '/apply/:profile_id', to: 'castings#apply', as: :apply, on: :member
  get '/invite/:profile_id', to: 'castings#invite', as: :invite, on: :member
  get '/confirm/:profile_id', to: 'castings#confirm', as: :confirm, on: :member
end

# Root
  root to: 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
