class ProfilePublishedJob < ApplicationJob
  queue_as :default

  def perform(profile)
    Notification.notify_profile_published(profile)
  end
end
