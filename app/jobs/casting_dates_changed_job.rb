class CastingDatesChangedJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	casting.intents.each do |intent|
  		case intent.status
  		when "invited"
  			Notification.notify_casting_dates_changed_invited(intent.profile_model, casting)
        CastingMailer.email_casting_dates_changed_invited(intent.profile_model, casting).deliver_now
  		when "confirmed"
  			Notification.notify_casting_dates_changed_confirmed(intent.profile_model, casting)
        CastingMailer.email_casting_dates_changed_confirmed(intent.profile_model, casting).deliver_now
  			intent.update(status: "invited")
  			intent.save
  		when "applied"
  			Notification.notify_casting_dates_changed_applied(intent.profile_model, casting)
        CastingMailer.email_casting_dates_changed_applied(intent.profile_model, casting).deliver_now
  			intent.destroy
  		end
	  end
  end
end
