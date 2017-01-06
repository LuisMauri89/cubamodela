namespace :casting_tasks do

	task working_test: :environment do
		Message.create(template: "inbox_message_casting_new_free", ownerable: ProfileModel.find(45), asociateable: Casting.last)
	end

	task casting_expiration_proximity_task: :environment do
		CastingExpirationProximityJob.perform_later
	end

	task casting_expired_task: :environment do
		CastingExpiredJob.perform_later
	end

	task casting_reviews_dont_show_again_task: :environment do
		CastingReviewsDontShowAgainJob.perform_later
	end
end
