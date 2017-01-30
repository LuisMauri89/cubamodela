class CouponSentJob < ApplicationJob
  queue_as :default

  def perform(profile, coupon)
    Notification.notify_coupon_sent(profile, coupon)
    CastingMailer.email_coupon_sent(profile, coupon).deliver_now
  end
end
