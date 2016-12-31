class CastingChangeDatesOnlyJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	casting.intents.each do |intent|
  		Notification.notify_casting_change_dates_only(intent.profile_model, casting)
        CastingMailer.email_casting_change_dates_only(intent.profile_model, casting).deliver_now

        case intent.status
  		when "confirmed"
  			intent.invited!
  		when "applied"
			intent.destroy
        end
	 end
  end
end
