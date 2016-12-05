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

	def model_pending_upgrade_level_review
		@requests = LevelRequest.model_requests
	end

	def accept_model_request_to_upgrade
		@request = LevelRequest.find(params[:level_request_id])

		respond_to do |format|
			if @request.accept

				@accept = true
				@request.destroy

				format.js
			else
				@accept = false

				format.js
			end
		end
	end

	def reject_model_request_to_upgrade
		@request = LevelRequest.find(params[:level_request_id])

		respond_to do |format|
			if @request.destroy
				format.js
			else
				format.js
			end
		end
	end

	def check_if_can
      authorize! action_name.to_s.to_sym, "Admin".to_sym
    end
end