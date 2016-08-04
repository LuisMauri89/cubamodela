Rails.application.routes.draw do	
	
# For Static Pages (like home page)		
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/contact'
  get 'static_pages/aboutus'

# Root
  root to: 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
