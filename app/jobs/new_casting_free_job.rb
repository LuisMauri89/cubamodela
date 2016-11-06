class NewCastingFreeJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	ProfileModel.each do |profile|
    	Notification.notify_new_casting_free(profile, casting)
	end
  end
end
