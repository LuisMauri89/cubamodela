class MessageSendJob < ApplicationJob
  queue_as :default

  def perform(profile, body)
    Notification.notify_message_send(profile, body)
    CustomMailer.email_message_send(profile, body).deliver_now
  end
end
