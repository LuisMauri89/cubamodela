class CastingApplicationConfirmationJob < ApplicationJob
  queue_as :default

  def perform(profile, casting)
    Notification.notify_casting_application_confirmation(profile, casting)
    CastingMailer.email_casting_application_confirmation(profile, casting).deliver_now
  end
end
