class ProfileRejectJob < ApplicationJob
  queue_as :default

  def perform(profile)
    Notification.notify_profile_reject(profile)
    ProfileMailer.email_profile_reject(profile).deliver_now
  end
end
