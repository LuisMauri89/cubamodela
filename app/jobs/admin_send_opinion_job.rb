class AdminSendOpinionJob < ApplicationJob
  queue_as :default

  def perform(body, created_at)
    User.admins.each do |admin|
    	CustomMailer.email_admin_send_opinion(admin, body, created_at).deliver_now
    end
  end
end
