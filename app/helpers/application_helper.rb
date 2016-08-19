module ApplicationHelper

  # For devise authetincation
  def resource_name
    :user
  end

  def resource_class 
     User 
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # For devise flash messages keys
  def get_bootstrap_key_from_devise_key(key)
    case key
    when "notice"
      "success"
    when "alert"
      "warning"
    when "error"
      "danger"
    else
      "success"
    end
  end

  # For profiles access methods
  def get_profile_path
    if current_user.profileable.nil?
      case current_user.kind
      when "contractor"
        new_profile_model_path
      when "model"
        new_profile_model_path
      when "photographer"
        new_profile_model_path
      end
    else
      case current_user.kind
      when "contractor"
        edit_profile_model_path(current_user.profileable)
      when "model"
        edit_profile_model_path(current_user.profileable)
      when "photographer"
        edit_profile_model_path(current_user.profileable)
      end
    end
  end

end
