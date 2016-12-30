class CastingTranslationJob < ApplicationJob
  queue_as :default

  def perform(casting)
  	ProfileModel.ready.each do |profile|
    	Notification.notify_casting_translation(profile, casting)
    	CastingMailer.email_casting_translation(profile, casting).deliver_now
	end
  end
end
