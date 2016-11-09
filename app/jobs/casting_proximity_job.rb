class CastingProximityJob < ApplicationJob
  queue_as :default

  def perform()
    Casting.valid_castings.each do |casting|
    	case casting.status
  		when "active"
  			if (casting.expiration_date.to_date - Date.today).to_i < 200
  				casting.intents.each do |intent|
  					case intent.status
  					when "invited"
  						Notification.notify_casting_invited_expiration_proximity(intent.profile_model, casting)
              CastingMailer.email_casting_invited_expiration_proximity(intent.profile_model, casting).deliver_now
  					else
  						Notification.notify_casting_available_expiration_proximity(intent.profile_model, casting)
              CastingMailer.email_casting_available_expiration_proximity(intent.profile_model, casting).deliver_now
  					end
  				end
  			end 
  		when "closed"
  			if (casting.casting_date.to_date - Date.today).to_i < 200
  				casting.intents.where(status: "invited").each do |intent|
  					Notification.notify_casting_invited_date_proximity(intent.profile_model, casting)
            CastingMailer.email_casting_invited_date_proximity(intent.profile_model, casting).deliver_now
  				end
  			end 
  		end
    end
  end
end
