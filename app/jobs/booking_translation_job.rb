class BookingTranslationJob < ApplicationJob
  queue_as :default

  def perform(profile, booking)
    Notification.notify_booking_translation(profile, booking)
    BookingMailer.email_booking_translation(profile, booking).deliver_now
  end
end
