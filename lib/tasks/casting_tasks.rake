namespace :casting_tasks do

	task working_test: :environment do
		Message.create(template: "inbox_message_casting_new_free", ownerable: ProfileModel.find(45), asociateable: Casting.last)
	end

	task casting_expiration_proximity_task: :environment do
		puts "#{Time.now} - START"
		Casting.actives.each do |casting|
			puts "#{Time.now} - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
	    	if (casting.expiration_date - Date.today) <= 5
	    		puts "#{Time.now} - Condition True"
	    		casting.intents.each do |intent|
	    			puts "#{Time.now} - Intent-#{intent.id}"
	    			Notification.notify_casting_expiration_proximity(intent.profile_model, casting)
	        		CastingMailer.email_casting_expiration_proximity(intent.profile_model, casting).deliver_now
	    		end
	    	end
    	end
		puts "#{Time.now} - Success!"
	end

	task casting_expired_task: :environment do
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
		puts "#{Time.now} - Success!"
	end

	task casting_reviews_dont_show_again_task: :environment do
		puts "#{Time.now} - START"
		Casting.after_reviews_time_elapsed.each do |casting|
			puts "#{Time.now} - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
	    	casting.casting_review.do_not_show_again
	    end
		puts "#{Time.now} - Success!"
	end
end
