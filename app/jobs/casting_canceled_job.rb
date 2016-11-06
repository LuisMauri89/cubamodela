class CastingCanceledJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	casting.intents.each do |intent|
  		Notification.notify_casting_canceled(intent.profile_model, casting)
	end
  end
end
