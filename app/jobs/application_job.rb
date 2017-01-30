class ApplicationJob < ActiveJob::Base
	rescue_from ActiveJob::DeserializationError do |exception|
	    Rails.logger.info("ActiveJob::DeserializationError at #{Time.now} with exception - #{exception}")
	end
end
