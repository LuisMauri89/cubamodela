class CastingApplicationJob < ApplicationJob
  queue_as :default

  def perform(contractor, casting, profile)
    Notification.notify_casting_application(contractor, casting, profile)
    CastingMailer.email_casting_application(contractor, casting, profile).deliver_now
  end
end
