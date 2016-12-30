class CastingExpiredJob < ApplicationJob
  queue_as :default

  def perform()
    Casting.actives.each do |casting|
    	if casting.expiration_date >= Date.today
    		casting.closed!

    		casting.intents.each do |intent|
		  		Notification.notify_casting_expired(intent.profile_model, casting)
		  		CastingMailer.email_casting_expired(intent.profile_model, casting).deliver_now
			end
    	end
    end
  end
end
