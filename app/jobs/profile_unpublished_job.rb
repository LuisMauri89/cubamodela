class ProfileUnpublishedJob < ApplicationJob
  queue_as :default

  def perform(profile)
    Notification.notify_profile_unpublished(profile)
  end
end
