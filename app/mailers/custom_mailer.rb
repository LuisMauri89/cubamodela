class CustomMailer < ApplicationMailer

	# Emails
	def email_message_send(profile, body)
		@profile = profile
		@body = body
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.custom.message_send.subject'))
	end

	def email_admin_send_opinion(admin, body)
		@admin = admin
		@body = body
		mail(to: @admin.email, subject: I18n.t('views.mailers.custom.admin_send_opinion.subject'))
	end

	def email_admin_send_app_status_notification(body)
		@body = body
		mail(to: "alejandropmauri@gmail.com", subject: "App status notification")
	end
end
