class ProfilePublishedJob < ApplicationJob
  queue_as :default

  def perform(profile)
    Notification.notify_profile_published(profile)
    ProfileMailer.email_profile_published(profile).deliver_now
  end
end
