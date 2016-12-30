class CastingExpirationProximityJob < ApplicationJob
  queue_as :default

  def perform()
    Casting.actives.each do |casting|
    	if (casting.expiration_date - Date.today) <= 5
    		casting.intents.each do |intent|
    			Notification.notify_casting_expiration_proximity(intent.profile_model, casting)
        		CastingMailer.email_casting_expiration_proximity(intent.profile_model, casting).deliver_now
    		end
    	end
    end
  end
end
