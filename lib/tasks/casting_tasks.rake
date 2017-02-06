namespace :casting_tasks do

	task casting_expiration_proximity_task: :environment do
		puts "#{Time.now} - START"
		Rails.logger.info "#{Time.current} - START_TASK: casting_expiration_proximity_task"
		Casting.actives.each do |casting|
			puts "#{Time.now} - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
			Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expiration_proximity_task - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
	    	if (casting.expiration_date.to_date - Date.today) <= 5
	    		puts "#{Time.now} - Condition True"
	    		Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expiration_proximity_task - Condition True"
	    		casting.intents.each do |intent|
	    			puts "#{Time.now} - Intent-#{intent.id}"
	    			Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expiration_proximity_task - Intent-#{intent.id}"
	    			Notification.notify_casting_expiration_proximity(intent.profile_model, casting)
	        		CastingMailer.email_casting_expiration_proximity(intent.profile_model, casting).deliver_now
	    		end
	    	end
    	end
		puts "#{Time.now} - Success!"
		Rails.logger.info "#{Time.current} - END_TASK: casting_expiration_proximity_task"
		CustomMailer.email_admin_send_app_status_notification("#{Time.current} - PERFORMED_TASK: casting_expiration_proximity_task")
	end

	task casting_expired_task: :environment do
		puts "#{Time.now} - START"
		Rails.logger.info "#{Time.current} - START_TASK: casting_expired_task"
	    Casting.actives.each do |casting|
	      	puts "#{Time.now} - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
	      	Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expired_task - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
	    	if casting.expiration_date <= Time.current
	        	puts "#{Time.now} - Condition True"
	        	Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expired_task - Condition True"
	        	Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expired_task - Current_Status-#{casting.status}"
	    		casting.closed!
	        	puts "#{Time.now} - Closed!"
	        	Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expired_task - Closed!"
	        	puts "#{Time.now} - Status-#{casting.status}"
	        	Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expired_task - New_Status-#{casting.status}"

	    		casting.intents.each do |intent|
	          		puts "#{Time.now} - Intent-#{intent.id}"
	          		Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_expired_task - Intent-#{intent.id}"
			  		Notification.notify_casting_expired(intent.profile_model, casting)
			  		CastingMailer.email_casting_expired(intent.profile_model, casting).deliver_now
				end
	    	end
	    end
		puts "#{Time.now} - Success!"
		Rails.logger.info "#{Time.current} - END_TASK: casting_expired_task"
		CustomMailer.email_admin_send_app_status_notification("#{Time.current} - PERFORMED_TASK: casting_expired_task")
	end

	task casting_reviews_dont_show_again_task: :environment do
		puts "#{Time.now} - START"
		Rails.logger.info "#{Time.current} - START_TASK: casting_reviews_dont_show_again_task"
		Casting.after_reviews_time_elapsed.each do |casting|
			puts "#{Time.now} - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
			Rails.logger.info "#{Time.current} - RUNNING_TASK: casting_reviews_dont_show_again_task - Casting-#{casting.title}-#{casting.id}-#{casting.expiration_date}"
	    	casting.casting_review.do_not_show_again
	    end
		puts "#{Time.now} - Success!"
		Rails.logger.info "#{Time.current} - END_TASK: casting_reviews_dont_show_again_task"
		CustomMailer.email_admin_send_app_status_notification("#{Time.current} - PERFORMED_TASK: casting_reviews_dont_show_again_task")
	end
end
