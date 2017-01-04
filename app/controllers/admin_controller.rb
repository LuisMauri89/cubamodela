class AdminController < ApplicationController
	before_action :authenticate_user!, only: [:control_panel, 
									    :model_pending_review, 
									    :pending_translations,
									    :model_pending_upgrade_level_review,
									    :accept_model_request_to_upgrade,
									    :reject_model_request_to_upgrade,
									    :coupons,
									    :create_coupons,
									    :send_coupon_to,
									    :send_coupon,
									    :give_coupon,
									    :exec_all,
									    :exec_casting_expiration,
									    :reprocess_images,
									    :message_for,
									    :send_message]
	before_action :check_if_can, only: [:control_panel, 
									    :model_pending_review, 
									    :pending_translations,
									    :model_pending_upgrade_level_review,
									    :accept_model_request_to_upgrade,
									    :reject_model_request_to_upgrade,
									    :coupons,
									    :create_coupons,
									    :send_coupon_to,
									    :send_coupon,
									    :give_coupon,
									    :exec_all,
									    :exec_casting_expiration,
									    :reprocess_images,
									    :message_for,
									    :send_message]
	before_action :set_request, only: [:accept_model_request_to_upgrade, 
									   :reject_model_request_to_upgrade]
	before_action :set_model_level_request_action_from, only: [:accept_model_request_to_upgrade, 
															   :reject_model_request_to_upgrade]

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

			if @success
				@coupons = Coupon.actives
				format.js
			else
				format.js
			end
		end
	end

	def send_coupon_to
		set_filter
		set_coupon

		if @filter
			@users = User.search_by_email(@filter)
		else
			@users = User.role_user
		end
	end

	def send_coupon
		set_coupon
		@coupon.give!

		set_user

		CouponSentJob.perform_later(@user.profileable, @coupon)

		respond_to do |format|
			format.html{ redirect_to coupons_path, notice: t('views.admin.coupons.messages.coupon_sent') }
		end
	end

	def give_coupon
		set_coupon
		@coupon.give!

		respond_to do |format|
			format.js
		end
	end

	def exec_casting_expiration
		CastingsExpiredJob.perform_later

		respond_to do |format|
			format.js
		end
	end

	def exec_all
		CastingsExpiredJob.perform_later
		CastingProximityJob.perform_later

		respond_to do |format|
			format.js
		end
	end

	def reprocess_images
		ReprocessImagesJob.perform_later

		respond_to do |format|
			format.js
		end
	end

	def message_for
		set_user
		@from_url = request.referrer
	end

	def send_message
		set_user
		@from_url = params[:from_url]
		@body = params[:message][:body]

		MessageSendJob.perform_later(@user.profileable, @body)

		redirect_to @from_url, notice: t('views.admin.message.message_sent')
	end

	def send_message_admin
		@body = params[:message][:body]
		AdminSendOpinionJob.perform_later(@body)

		redirect_to root_url, notice: t('views.admin.message.message_sent')
	end

	private

		def set_request
			@request = LevelRequest.find(params[:level_request_id])
		end

		def set_model_level_request_action_from
			@from = params[:from]
		end

		def set_coupon
			@coupon = Coupon.actives.find(params[:coupon_id])
		end

		def set_user
			@user = User.find(params[:user_id])
		end

		def set_filter
			@filter = params[:filter]
		end

		def check_if_can
	      authorize! action_name.to_s.to_sym, "Admin".to_sym
	    end

	    def coupons_params
	      params.require(:values).permit(:how_many, :amount)
	    end
end