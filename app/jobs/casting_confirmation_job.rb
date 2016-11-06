class CastingConfirmationJob < ApplicationJob
  queue_as :default

  def perform(contractor, casting, profile)
    Notification.notify_casting_confirmation(contractor, casting, profile)
  end
end
