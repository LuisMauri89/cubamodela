namespace :casting_tasks do

	task working_test: :environment do
		Message.create(template: "inbox_message_new_casting_free", ownerable: ProfileModel.find(45), asociateable: Casting.first)
	end

	task alert_casting_proximity: :environment do
		CastingProximityJob.perform_later
	end

	task change_casting_expired_status: :environment do
		CastingsExpiredJob.perform_later
	end
end
