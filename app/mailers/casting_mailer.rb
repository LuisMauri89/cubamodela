class CastingMailer < ApplicationMailer

	# Emails
	def email_casting_invitation(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_invitation.subject', value: @casting.title))
	end

	def email_casting_confirmation(contractor, casting, profile)
		@contractor = contractor
		@casting = casting
		@profile = profile
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_confirmation.subject', value: @casting.title))
	end

	def email_casting_application(contractor, casting, profile)
		@contractor = contractor
		@casting = casting
		@profile = profile
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_application.subject', value: @casting.title))
	end

	def email_casting_application_confirmation(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_application_confirmation.subject', value: @casting.title))
	end

	def email_new_casting_free(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.new_casting_free.subject', value: @casting.title))
	end

	def email_casting_dates_changed_invited(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_dates_changed_invited.subject', value: @casting.title))
	end

	def email_casting_dates_changed_confirmed(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_dates_changed_confirmed.subject', value: @casting.title))
	end

	def email_casting_dates_changed_applied(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_dates_changed_applied.subject', value: @casting.title))
	end

	def email_casting_closed(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_closed.subject', value: @casting.title))
	end

	def email_casting_canceled(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_canceled.subject', value: @casting.title))
	end

	def email_profile_published(profile)
		@profile = profile
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.profile_published.subject', value: @profile.get_first_name))
	end

	def email_profile_unpublished(profile)
		@profile = profile
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.profile_unpublished.subject', value: @profile.get_first_name))
	end

	def email_casting_available_expiration_proximity(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_available_expiration_proximity.subject', value: @casting.title))
	end

	def email_casting_invited_expiration_proximity(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_invited_expiration_proximity.subject', value: @casting.title))
	end

	def email_casting_invited_date_proximity(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_invited_date_proximity.subject', value: @casting.title))
	end
end
