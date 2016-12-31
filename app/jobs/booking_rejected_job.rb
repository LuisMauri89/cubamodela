class BookingRejectedJob < ApplicationJob
  queue_as :default

  def perform(contractor, booking, profile)
    Notification.notify_booking_rejected(contractor, booking, profile)
    CastingMailer.email_booking_rejected(contractor, booking, profile).deliver_now
  end
end
