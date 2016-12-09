class AdminController < ApplicationController
	before_action :authenticate_user!
	before_action :check_if_can, only: [:control_panel, :model_pending_review, :pending_translations]
	before_action :set_request, only: [:accept_model_request_to_upgrade, :reject_model_request_to_upgrade]
	before_action :set_model_level_request_action_from, only: [:accept_model_request_to_upgrade, :reject_model_request_to_upgrade]

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
		respond_to do |format|
			if @request.accept

				@accept = true
				@request_id = @request.id

				@request.destroy

				format.js
			else
				@accept = false

				format.js
			end
		end
	end

	def reject_model_request_to_upgrade
		respond_to do |format|
		if @request.destroy
				format.js
			else
				format.js
			end
		end
	end

	def coupons
		@coupons = Coupon.actives
	end

	def create_coupons
		count = coupons_params[:how_many].to_i
		amount = coupons_params[:amount].to_f
		coupon_count = Coupon.actives.count

		1.upto(count) do
			Coupon.create(amount: amount)
		end

		respond_to do |format|
			@success = (coupon_count + count) == Coupon.actives.count
			format.js
		end
	end

	private

		def set_request
			@request = LevelRequest.find(params[:level_request_id])
		end

		def set_model_level_request_action_from
			@from = params[:from]
		end

		def check_if_can
	      authorize! action_name.to_s.to_sym, "Admin".to_sym
	    end

	    def coupons_params
	      params.require(:values).permit(:how_many, :amount)
	    end
end