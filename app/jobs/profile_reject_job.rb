class ProfileRejectJob < ApplicationJob
  queue_as :default

  def perform(profile)
    Notification.notify_profile_reject(profile)
    CastingMailer.email_profile_reject(profile).deliver_now
  end
end
