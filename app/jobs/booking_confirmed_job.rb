class BookingConfirmedJob < ApplicationJob
  queue_as :default

  def perform(contractor, booking, profile)
    Notification.notify_booking_confirmed(contractor, booking, profile)
    CastingMailer.email_booking_confirmed(contractor, booking, profile).deliver_now
  end
end
