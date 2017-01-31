class CastingInvitationConfirmedJob < ApplicationJob
  queue_as :default

  def perform(contractor, casting, profile)
    Notification.notify_casting_invitation_confirmed(contractor, casting, profile)
    CastingMailer.email_casting_invitation_confirmed(contractor, casting, profile).deliver_now
  end
end
