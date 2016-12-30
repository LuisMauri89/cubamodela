class CastingNewFreeJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	ProfileModel.ready.each do |profile|
    	Notification.notify_casting_new_free(profile, casting)
    	CastingMailer.email_casting_new_free(profile, casting).deliver_now
	end
  end
end
