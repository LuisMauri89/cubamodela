class BookingChangeFieldsAndDatesJob < ApplicationJob
  queue_as :default

  def perform(profile, booking)
    Notification.notify_booking_change_fields_and_dates(profile, booking)
    CastingMailer.email_booking_change_fields_and_dates(profile, booking).deliver_now

    if booking.status == "confirmed" || booking.status == "rejected"
    	booking.booked!
    end
  end
end
