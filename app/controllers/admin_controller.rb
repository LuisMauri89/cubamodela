class AdminController < ApplicationController
	before_action :authenticate_user!
	before_action :check_if_can, only: [:control_panel, :model_pending_review, :pending_translations]

	def control_panel
	end

	def model_pending_review
		@models = ProfileModel.not_ready
	end

	def pending_translations
		@castings = Casting.needs_translation
		@bookings = Booking.needs_translation
		@reviews = Review.needs_translation
	end

	def check_if_can
      authorize! action_name.to_s.to_sym, "Admin".to_sym
    end
end