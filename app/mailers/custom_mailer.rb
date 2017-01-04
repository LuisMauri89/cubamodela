class CustomMailer < ApplicationMailer

	# Emails
	def email_message_send(profile, body)
		@profile = profile
		@body = body
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.custom.message_send.subject'))
	end
end
