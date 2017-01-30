class CastingInvitationJob < ApplicationJob
  queue_as :default

  def perform(profile, casting)
    Notification.notify_casting_invitation(profile, casting)
    CastingMailer.email_casting_invitation(profile, casting).deliver_now
  end
end
