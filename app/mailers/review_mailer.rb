class ReviewMailer < ApplicationMailer

	# Emails
	def email_review_new(profile, contractor)
		@profile = profile
		@contractor = contractor
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.review.review_new.subject', value: @contractor.get_first_name))
	end
end
