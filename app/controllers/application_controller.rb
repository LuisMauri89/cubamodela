class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters_for_devise, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters_for_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:kind])
  end

end
