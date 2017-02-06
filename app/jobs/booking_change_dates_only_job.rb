class BookingChangeDatesOnlyJob < ApplicationJob
  queue_as :default

  def perform(profile, booking)
    Notification.notify_booking_change_dates_only(profile, booking)
    BookingMailer.email_booking_change_dates_only(profile, booking).deliver_now

    if booking.status == "confirmed" || booking.status == "rejected"
    	booking.booked!
    end
  end
end
