class CustomMailer < ApplicationMailer

	# Emails
	def email_message_send(profile, body)
		@profile = profile
		@body = body
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.custom.message_send.subject'))
	end

	def email_admin_send_opinion(admin, body, created_at)
		@admin = admin
		@body = body
		@created_at = created_at
		mail(to: @admin.email, subject: I18n.t('views.mailers.custom.admin_send_opinion.subject'))
	end
end
