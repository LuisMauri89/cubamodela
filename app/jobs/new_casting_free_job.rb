class NewCastingFreeJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	ProfileModel.ready.each do |profile|
    	Notification.notify_new_casting_free(profile, casting)
    	CastingMailer.email_new_casting_free(profile, casting).deliver_now
	end
  end
end
