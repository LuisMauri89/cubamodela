class BookingCanceledJob < ApplicationJob
  queue_as :default

  def perform(profile, booking)
    Notification.notify_booking_canceled(profile, booking)
    CastingMailer.email_booking_canceled(profile, booking).deliver_now
  end
end
