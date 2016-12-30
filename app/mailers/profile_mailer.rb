class ProfileMailer < ApplicationMailer
	
	# Emails
	def email_profile_published(profile)
		@profile = profile
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.profile.profile_published.subject', value: @profile.get_first_name))
	end

	def email_profile_unpublished(profile)
		@profile = profile
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.profile.profile_unpublished.subject', value: @profile.get_first_name))
	end

	def email_profile_reject(profile)
		@profile = profile
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.profile.profile_reject.subject', value: @profile.get_first_name))
	end

	def email_profile_warning(profile)
		@profile = profile
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.profile.profile_warning.subject', value: @profile.get_first_name))
	end
end
