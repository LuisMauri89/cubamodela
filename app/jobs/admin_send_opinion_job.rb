class AdminSendOpinionJob < ApplicationJob
  queue_as :default

  def perform(body)
    User.admins.each do |admin|
    	CustomMailer.email_admin_send_opinion(admin, body).deliver_now
    end
  end
end
