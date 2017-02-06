class BookingCanceledJob < ApplicationJob
  queue_as :default

  def perform(profile, booking)
    Notification.notify_booking_canceled(profile, booking)
    BookingMailer.email_booking_canceled(profile, booking).deliver_now
  end
end
