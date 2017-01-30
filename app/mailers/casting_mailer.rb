class CastingMailer < ApplicationMailer

	# Emails
	def email_casting_new_free(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_new_free.subject', value: @casting.title))
	end

	def email_casting_translation(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_translation.subject', value: @casting.title))
	end

	def email_casting_change_fields_only(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_change_fields_only.subject', value: @casting.title))
	end

	def email_casting_change_dates_only(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_change_dates_only.subject', value: @casting.title))
	end

	def email_casting_change_fields_and_dates(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_change_fields_and_dates.subject', value: @casting.title))
	end

	def email_casting_expiration_proximity(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_expiration_proximity.subject', value: @casting.title))
	end

	def email_casting_expired(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_expired.subject', value: @casting.title))
	end

	def email_casting_canceled(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_canceled.subject', value: @casting.title))
	end

	def email_casting_invitation(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_invitation.subject', value: @casting.title))
	end

	def email_casting_invitation_confirmed(contractor, casting, profile)
		@contractor = contractor
		@casting = casting
		@profile = profile
		mail(to: @contractor.user.email, subject: I18n.t('views.mailers.casting.casting_invitation_confirmed.subject', value: @casting.title))
	end

	def email_casting_application(contractor, casting, profile)
		@contractor = contractor
		@casting = casting
		@profile = profile
		mail(to: @contractor.user.email, subject: I18n.t('views.mailers.casting.casting_application.subject', value: @casting.title))
	end

	def email_casting_application_confirmed(profile, casting)
		@profile = profile
		@casting = casting
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.casting_application_confirmed.subject', value: @casting.title))
	end
end
