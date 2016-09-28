class SettingsController < ApplicationController
	def change_locale
		locale = params[:locale].to_s.strip.to_sym
		locale = I18n.default_locale unless I18n.available_locales.include?(locale)
		cookies.permanent[:current_locale] = locale
		redirect_to request.referer || root_url
	end
end
