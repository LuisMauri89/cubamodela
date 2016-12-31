class CastingReviewsDontShowAgainJob < ApplicationJob
  queue_as :default

  def perform()
    Casting.after_reviews_time_elapsed.each do |casting|
    	casting.casting_review.do_not_show_again
    end
  end
end
