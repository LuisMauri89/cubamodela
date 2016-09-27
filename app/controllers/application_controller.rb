class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters_for_devise, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  # For Devise
  def configure_permitted_parameters_for_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:kind])
  end

  def after_sign_up_path_for(resource)
  	get_profile_path
  end

  # For CanCanCan
  rescue_from CanCan::AccessDenied do |exception|
	  flash[:error] = "Access denied!"
	  redirect_to root_url
  end

end
