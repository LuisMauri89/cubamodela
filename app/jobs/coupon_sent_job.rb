class CouponSentJob < ApplicationJob
  queue_as :default

  def perform(profile, coupon)
  	# Send coupon to user
    Notification.notify_coupon_sent(profile, coupon)
    CouponMailer.email_coupon_sent(profile, coupon).deliver_now
  end
end
