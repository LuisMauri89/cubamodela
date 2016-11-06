class CastingApplicationJob < ApplicationJob
  queue_as :default

  def perform(contractor, casting, profile)
    Notification.notify_casting_application(contractor, casting, profile)
  end
end
