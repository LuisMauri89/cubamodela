class BookingConfirmedJob < ApplicationJob
  queue_as :default

  def perform(contractor, booking, profile)
    Notification.notify_booking_confirmed(contractor, booking, profile)
    BookingMailer.email_booking_confirmed(contractor, booking, profile).deliver_now
  end
end
