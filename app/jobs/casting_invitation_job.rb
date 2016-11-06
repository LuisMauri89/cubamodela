class CastingInvitationJob < ApplicationJob
  queue_as :default

  def perform(profile, casting)
    Notification.notify_casting_invitation(profile, casting)
  end
end
