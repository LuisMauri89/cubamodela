namespace :casting_tasks do

	task working_test: :environment do
		Message.create(template: "inbox_message_new_casting_free", ownerable: ProfileModel.find(45), asociateable: Casting.first)
	end

	task casting_expiration_proximity_task: :environment do
		CastingExpirationProximityJob.perform_later
	end

	task casting_expired_task: :environment do
		CastingExpiredJob.perform_later
	end
end
