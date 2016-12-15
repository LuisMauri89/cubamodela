class CastingsExpiredJob < ApplicationJob
  queue_as :default

  def perform()
    Casting.actives.each do |casting|
    	if casting.expiration_date >= Date.today
    		casting.closed!
    		# casting.save
    	end
    end
  end
end
