Rails.application.routes.draw do

# For internationalization
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

# Devise routes
  devise_for :users, :path => 'account', :controllers => {:registrations => "registrations"}

# Users routes
  resources :users, only: [:index]

# For Static Pages (like home page)		
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/contact'
  get 'static_pages/aboutus'
  get 'static_pages/xuan'
  get 'static_pages/camila'
  get 'static_pages/patricio'
  get 'static_pages/profile_example'
  get 'static_pages/gallery'
  get 'static_pages/show_gallery_photo'

# Models Profile routes
  resources :profile_models do
    get 'albums', on: :member
    get 'studies', on: :member
    get 'plans', on: :member
    get 'show_resume', on: :member
    get 'show_professional_photos', on: :member
    get 'show_polaroid_photos', on: :member
    get 'show_selected_photo/:photo_id', to: 'profile_models#show_selected_photo', as: :selected_photo, on: :member
    get 'vote/:votant_id/:votant_type', to: 'profile_models#vote', as: :vote, on: :member
    get 'publish', on: :member
    get 'no_publish', on: :member
    get 'reject_publish', on: :member
    get 'warning_publish', on: :member
    get 'reset_warnings', on: :member
    get 'request_level', on: :member
    get 'search', to: 'profile_models#index_search', on: :collection
    post 'search', to: 'profile_models#perform_search', on: :collection
    get 'index_new_faces', on: :collection
    get 'index_professional_models', on: :collection
    get 'index_premium_models', on: :collection
    get 'index_castings_custom', on: :member
  end

# Photographers Profile routes
  resources :profile_photographers do
    get 'albums', on: :member
    get 'studies', on: :member
    get 'plans', on: :member
    get 'show_resume', on: :member
  end

# Models Profile routes
  resources :profile_contractors do
    get 'plans', on: :member
  end

# Colors routes
  resources :colors

# Provinces routes
  resources :provinces

# Languages routes
  resources :languages

# Expertises routes
  resources :expertises

# Modalities routes
  resources :modalities

# Nationalities routes
  resources :nationalities

# Reviews routes
  resources :reviews do
    get 'translate', on: :member
  end

# Categories routes
  resources :categories

# Ethnicities routes
  resources :ethnicities

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
    get '/show_photo/:photo_id', to: 'castings#show_photo', as: :show_photo, on: :member
    concerns :attachable
    get 'manage', on: :member
    get 'close', on: :member
    get 'cancel', on: :member
    get 'activate', on: :member
    get '/custom/index/:contractor_id', to: 'castings#index_custom', as: :custom_index, on: :collection
    get '/custom/index/invite/:contractor_id/:profile_id', to: 'castings#index_custom_invite', as: :custom_index_invite, on: :collection
    get '/invite/index/', to: 'castings#index_invite', on: :member
    get '/invited/index/', to: 'castings#index_invited', on: :member
    get '/confirmed/index/', to: 'castings#index_confirmed', on: :member
    get '/favorites/index/', to: 'castings#index_favorites', on: :member
    get '/applied/index/', to: 'castings#index_applied', on: :member
    get '/apply/:profile_id', to: 'castings#apply', as: :apply, on: :member
    get '/invite/:profile_id', to: 'castings#invite', as: :invite, on: :member
    get '/confirm/:profile_id', to: 'castings#confirm', as: :confirm, on: :member
    get 'translate', on: :member
    get '/index_left_reviews/:casting_review_id', to: 'castings#index_left_reviews', as: :index_left_reviews, on: :collection
    get '/dont_show_again_casting_reviews/:casting_review_id', to: 'castings#dont_show_again_casting_reviews', as: :dont_show_again_casting_reviews, on: :collection
    get '/casting_reviews/:contractor_id', to: 'castings#casting_reviews', as: :casting_reviews, on: :collection
  end

# Bookings routes
  resources :bookings do
    get '/custom/index/contractor/:contractor_id', to: 'bookings#index_custom_contractor', as: :custom_index_contractor, on: :collection
    get '/custom/index/model/:model_id', to: 'bookings#index_custom_model', as: :custom_index_model, on: :collection
    get '/confirm/:profile_id', to: 'bookings#confirm', as: :confirm, on: :member
    get 'translate', on: :member
    get 'cancel', on: :member
    get '/reject/:profile_id', to: 'bookings#reject', as: :reject, on: :member
  end

# Admin routes
  scope '/admin' do
    get '/control_panel/', to: 'admin#control_panel', as: :control_panel
    get '/model_pending_review/', to: 'admin#model_pending_review', as: :model_pending_review
    get '/pending_translations/', to: 'admin#pending_translations', as: :pending_translations
    get '/model_pending_upgrade_level_review/', to: 'admin#model_pending_upgrade_level_review', as: :model_pending_upgrade_level_review
    get '/accept_model_request_to_upgrade/:level_request_id', to: 'admin#accept_model_request_to_upgrade', as: :accept_model_request_to_upgrade
    get '/reject_model_request_to_upgrade/:level_request_id', to: 'admin#reject_model_request_to_upgrade', as: :reject_model_request_to_upgrade
    get '/coupons/', to: 'admin#coupons', as: :coupons
    post '/create_coupons/', to: 'admin#create_coupons', as: :create_coupons
    get '/send_coupon_to/:coupon_id', to: 'admin#send_coupon_to', as: :send_coupon_to
    get '/send_coupon/:coupon_id/:user_id', to: 'admin#send_coupon', as: :send_coupon
    get '/exec_casting_expiration', to: 'admin#exec_casting_expiration', as: :exec_casting_expiration
    get '/exec_all', to: 'admin#exec_all', as: :exec_all
    get '/reprocess_images', to: 'admin#reprocess_images', as: :reprocess_images
    get '/give_coupon/:coupon_id', to: 'admin#give_coupon', as: :give_coupon
    get '/message_for/:user_id', to: 'admin#message_for', as: :message_for
    post '/send_message/', to: 'admin#send_message', as: :send_message
    post '/send_message_admin/', to: 'admin#send_message_admin', as: :send_message_admin
    get '/set_as_partner/:user_id', to: 'admin#set_as_partner', as: :set_as_partner
    get '/unset_as_partner/:user_id', to: 'admin#unset_as_partner', as: :unset_as_partner
  end

# Coupons routes
  scope '/coupons' do
    post 'charge_coupon', to: 'coupons#charge_coupon', as: :charge_coupon
    get 'index', to: 'coupons#index'
  end

# Root
  root to: 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
