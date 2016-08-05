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

end
