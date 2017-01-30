class CouponMailer < ApplicationMailer

	# Emails
	def email_coupon_sent(profile, coupon)
		@profile = profile
		@coupon = coupon
		mail(to: @profile.user.email, subject: I18n.t('views.mailers.casting.coupon_sent.subject'))
	end
end
