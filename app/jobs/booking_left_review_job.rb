class BookingLeftReviewJob < ApplicationJob
  queue_as :default

  def perform(contractor, booking, profile)
    Notification.notify_booking_left_review(contractor, booking, profile)
    BookingMailer.email_booking_left_review(contractor, booking, profile).deliver_now
  end
end
