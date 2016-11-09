class ProfileUnpublishedJob < ApplicationJob
  queue_as :default

  def perform(profile)
    Notification.notify_profile_unpublished(profile)
    CastingMailer.email_profile_unpublished(profile).deliver_now
  end
end
