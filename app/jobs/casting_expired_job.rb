class CastingExpiredJob < ApplicationJob
  queue_as :default

  def perform()
    puts "#{Time.now} - START"
    Casting.actives.each do |casting|
      puts "#{Time.now} - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
    	if casting.expiration_date <= Date.today
        puts "#{Time.now} - Condition True"
    		casting.closed!
        puts "#{Time.now} - Closed!"
        puts "#{Time.now} - Status-#{casting.status}"

    		casting.intents.each do |intent|
          puts "#{Time.now} - Intent-#{intent.id}"
		  		Notification.notify_casting_expired(intent.profile_model, casting)
		  		CastingMailer.email_casting_expired(intent.profile_model, casting).deliver_now
			  end
    	end
    end
  end
end
