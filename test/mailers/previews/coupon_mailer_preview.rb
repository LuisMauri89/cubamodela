# Preview all emails at http://localhost:3000/rails/mailers/coupon_mailer
class CouponMailerPreview < ActionMailer::Preview
	def email_coupon_sent
		CouponMailer.email_coupon_sent(ProfileModel.find(45), Coupon.actives.last)
	end
end
