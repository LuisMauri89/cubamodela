class BookingInvitationJob < ApplicationJob
  queue_as :default

  def perform(profile, booking)
    Notification.notify_booking_invitation(profile, booking)
    BookingMailer.email_booking_invitation(profile, booking).deliver_now
  end
end
