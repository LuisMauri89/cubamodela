class CastingCanceledJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	casting.intents.each do |intent|
  		Notification.notify_casting_canceled(intent.profile_model, casting)
  		CastingMailer.email_casting_canceled(intent.profile_model, casting).deliver_now
	end
  end
end
