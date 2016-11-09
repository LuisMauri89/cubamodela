class CastingConfirmationJob < ApplicationJob
  queue_as :default

  def perform(contractor, casting, profile)
    Notification.notify_casting_confirmation(contractor, casting, profile)
    CastingMailer.email_casting_confirmation(contractor, casting, profile).deliver_now
  end
end
