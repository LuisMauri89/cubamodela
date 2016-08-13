class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters_for_devise, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters_for_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:kind])
  end

  def after_sign_up_path_for(resource)
	if current_user.profileable.nil?
		new_profile_model_path
	else
		edit_profile_model_path(current_user.profileable)
	end
  end

end
