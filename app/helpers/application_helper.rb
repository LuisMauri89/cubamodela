module ApplicationHelper

  # For Navbar
  def get_navbar_items_size
    default_size = 20
    if user_signed_in?
      if current_user.admin?
        return default_size
      else
        default_size = 20
        return default_size
      end
    else
      return default_size
    end
  end

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

  def get_kind_collection
    collection = [[t('activerecord.attributes.user.kind_options.select'), 'white']]
    User.kinds.keys.reject{ |k| k == "other" || k == "white" }.map {|kind| collection << [t('activerecord.attributes.user.kind_options.' + kind),kind]}

    return collection
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

  def get_profile_percent
    if current_user.profileable.nil?
      return "0%"
    else
      return current_user.profileable.profile_complete_progress_percentage.to_s << "%"
    end
  end

  def get_profile_inbox_count
    if current_user.profileable.nil?
      return "0"
    else
      return current_user.profileable.messages.where(readed: false).count.to_s
    end
  end

  def get_valid_castings_count
    if current_user.profileable.nil?
      return "0"
    else
      return current_user.profileable.valid_castings.count.to_s
    end
  end

  def get_active_bookings_count
    if current_user.profileable.nil?
      return "0"
    else
      return current_user.profileable.valid_bookings.count.to_s
    end
  end

  def get_active_castings
    return Casting.valid_castings.count.to_s
  end

  # For users counts
  def get_models_count
    ProfileModel.count
  end

  def get_photographers_count
    ProfilePhotographer.count
  end

  def get_contractors_count
    ProfileContractor.count
  end

  # For premium
  def get_premium_border(profile)
    return profile.premium? ? "premium-border" : ""
  end

end
