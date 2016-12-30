class BookingMailer < ApplicationMailer
	# Emails
	def email_booking_invitation(profile, booking)
		@profile = profile
		@booking = booking
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.booking.booking_invitation.subject', value: @booking.description[0..50]))
	end

	def email_booking_confirmed(profile, booking)
		@profile = profile
		@booking = booking
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.booking.booking_confirmed.subject', value: @booking.description[0..50]))
	end

	def email_booking_rejected(profile, booking)
		@profile = profile
		@booking = booking
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.booking.booking_rejected.subject', value: @booking.description[0..50]))
	end

	def email_booking_canceled(profile, booking)
		@profile = profile
		@booking = booking
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.booking.booking_canceled.subject', value: @booking.description[0..50]))
	end

	def email_booking_translation(profile, booking)
		@profile = profile
		@booking = booking
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.booking.booking_translation.subject', value: @booking.description[0..50]))
	end

	def email_booking_change_fields_only(profile, booking)
		@profile = profile
		@booking = booking
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.booking.booking_change_fields_only.subject', value: @booking.description[0..50]))
	end

	def email_booking_change_dates_only(profile, booking)
		@profile = profile
		@booking = booking
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.booking.booking_change_dates_only.subject', value: @booking.description[0..50]))
	end

	def email_booking_change_fields_and_dates(profile, booking)
		@profile = profile
		@booking = booking
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.booking.booking_change_fields_and_dates.subject', value: @booking.description[0..50]))
	end
end
