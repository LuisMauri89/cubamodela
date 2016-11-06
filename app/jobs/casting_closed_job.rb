class CastingClosedJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	casting.intents.where(status: "invited").each do |intent|
  		Notification.notify_casting_closed(intent.profile_model, casting)
	end
  end
end
