class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters_for_devise, if: :devise_controller?
  before_action :prepare_meta_tags, if: "request.get?"
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

  # For meta tags
  def prepare_meta_tags(options={})
    site_name   = "CubaModela"
    title       = get_meta_title
    separator   = " | "
    description = get_meta_description
    keywords    = get_meta_keywords
    image       = options[:image] || "https://www.cubamodela.com/assets/cubamodela_logo_blue.png"
    current_url = request.url
    viewport    = "width=device-width,initial-scale=1"

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      separator:   separator,
      reverse:     true,
      viewport: viewport,
      language:    I18n.locale,
      image:       image,
      description: description,
      keywords:    keywords,
      twitter: {
        site_name: site_name,
        site: '@cubamodela',
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      },
      p: {
        domain_verify: 'd952f3fb98d0ee095db6f5b4e38979c5'
      },
      "google-site-verification": 'YxMd7hSKe8mdjw7f7vxAtgoDGQ0MvePFwJaDXDHyILQ'
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

  def get_meta_title
    return I18n.locale == "es".to_sym ? "Modelos Cubanos, Fotografos, Lugares" : "Cuban Models, Photographers, Locations"
  end

  def get_meta_description
    return I18n.locale == "es".to_sym ? "Somos la red profesional de la moda y la fotografia en Cuba. Descubre modelos y fotografos cubanos, asi como lugares unicos para sus fotografias." : "We are the Professional Network of Fashion and Photography in Cuba. Discover Cuban models and photographers as well as unique locations for photos."
  end

  def get_meta_keywords
    return I18n.locale == "es".to_sym ? %w[modelos fotografos Cuba modelo fotografo] : %w[models photographers Cuba model photographer]
  end

  def generate_list_on_columns_container(collection, columns)
    if collection != nil && columns > 1

      @column_size = 12 / columns
      
      columns_index = 0
      @container = []

      columns.times do
        @container << []
      end

      collection.each do |item|
        @container[columns_index] << item

        columns_index = columns_index == (columns - 1) ? 0 : columns_index + 1
      end

    end
  end

end
