class BookingChangeFieldsOnlyJob < ApplicationJob
  queue_as :default

  def perform(profile, booking)
    Notification.notify_booking_change_fields_only(profile, booking)
    BookingMailer.email_booking_change_fields_only(profile, booking).deliver_now
  end
end
