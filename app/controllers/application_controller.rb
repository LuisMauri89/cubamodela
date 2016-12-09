class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters_for_devise, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  # For Devise
  def configure_permitted_parameters_for_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:kind])
  end

  # def after_sign_up_path_for(resource)
  # 	get_profile_path
  # end

  # For CanCanCan
  rescue_from CanCan::AccessDenied do |exception|
	  flash[:error] = "Access denied!"
	  redirect_to root_url
  end

  # For internationalization
  def set_locale
    if cookies[:current_locale] && I18n.available_locales.include?(cookies[:current_locale].to_sym)
      locale = cookies[:current_locale].to_sym
    else
      locale = I18n.default_locale
      cookies.permanent[:current_locale] = locale
    end

    I18n.locale = locale
  end

  # For profiles access methods
  def get_profile_path
    if current_user.profileable.nil?
      case current_user.kind
      when "contractor"
        return new_profile_contractor_path
      when "model"
        return new_profile_model_path
      when "photographer"
        return new_profile_photographer_path
      end
    else
      case current_user.kind
      when "contractor"
        return edit_profile_contractor_path(current_user.profileable)
      when "model"
        return edit_profile_model_path(current_user.profileable)
      when "photographer"
        return edit_profile_photographer_path(current_user.profileable)
      end
    end
  end

  # Charge
  def charge(amount)
    # current_user.profileable.charge....
  end

end
