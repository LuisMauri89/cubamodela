class CastingsExpiredJob < ApplicationJob
  queue_as :default

  def perform()
    Casting.actives.each do |casting|
    	if casting.expiration_date >= Date.today
    		casting.closed!
    	end
    end
  end
end
