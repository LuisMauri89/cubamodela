class BookingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_booking, only: [:show, :edit, :translate, :cancel, :update, :confirm, :reject, :destroy]
	before_action :set_profile, only: [:new, :create, :edit, :update, :confirm, :reject]
	before_action :check_if_can, only: [:edit, :update, :destroy, :index_custom_contractor, :index_custom_model, :confirm, :cancel]

	def index_custom_contractor
		@contractor = ProfileContractor.find(params[:contractor_id])

		@bookings = @contractor.valid_bookings
	end

	def index_custom_model
		@model = ProfileModel.find(params[:model_id])

		@bookings = @model.index_bookings
	end

	def show
	    respond_to do |format|
	    	format.html
	    end
	end

	def new
	  @booking = Booking.new

	  authorize! :new, @booking
	end

	def create
		@booking = Booking.new(booking_params)
		@booking.profile_contractor = current_user.profileable

		authorize! :create, @booking

		respond_to do |format|
	  		if @booking.valid?

		        @charge_success, @message = Bank.charge(current_user.profileable, Constant::BOOKING_CREATION_COST.to_f, "booking_creation", false)
		        if @charge_success
		          @booking.save
		          # CastingReview.create(casting: @casting, profile_contractor: @casting.ownerable, show_again: true)
		          BookingInvitationJob.perform_later(@booking.profile_model, @booking)
		          format.html { redirect_to custom_index_contractor_bookings_path(@booking.profile_contractor), notice: I18n.t('views.bookings.messages.create') }
		        else
		          format.html { render :new }
		        end
	  		else
	  			format.html { render :new }
	  		end
	  	end
	end

	def edit
	  	if @booking.expired?
	  		redirect_to custom_index_contractor_bookings_path(@booking.profile_contractor), notice: I18n.t('views.bookings.messages.edit.past_to_edit')
	  	end
	end

	def translate
	    respond_to do |format|
	      format.html
	    end
	end

	def update
	  	respond_to do |format|
	  	  old_booking = Booking.find(params[:id])
		  if @booking.valid?
        
	        if @booking.update_requires_charge(old_booking)
	          @charge_success, @message = Bank.charge(current_user.profileable, Constant::BOOKING_UPDATE_DATES_CHANGE_COST.to_f, "booking_dates_change", false)
	          if @charge_success

	            @booking.update(booking_params)
	            @booking.send_update_notification(old_booking)

	            format.html { redirect_to custom_index_contractor_bookings_path(@booking.profile_contractor), notice: I18n.t('views.bookings.messages.update') }
	          else
	            format.html { render :edit }
	          end
	        else
	          @booking.update(booking_params)
	          @booking.send_update_notification(old_booking)

	          format.html { redirect_to custom_index_contractor_bookings_path(@booking.profile_contractor), notice: I18n.t('views.bookings.messages.update') }
	        end
	      else
	        format.html { render :edit }
	      end
	    end
	end

	def confirm
		@from = params[:from]
	    @booking.try_confirm!

	    respond_to do |format|
	      if @booking.save
	      	BookingConfirmedJob.perform_later(@booking.profile_contractor, @booking, @booking.profile_model)
	        format.js
	      else
	        format.js
	      end
	    end
	end

	def reject
		@from = params[:from]
	    @booking.try_reject!

	    respond_to do |format|
	      if @booking.save
	      	BookingRejectedJob.perform_later(@booking.profile_contractor, @booking, @booking.profile_model)
	        format.js
	      else
	        format.js
	      end
	    end
	end

	def cancel
	    @booking.try_cancel!

	    respond_to do |format|
	      if @booking.save
	      	BookingCanceledJob.perform_later(@booking.profile_model, @booking)
	        format.html{ redirect_to custom_index_contractor_bookings_path(@booking.profile_contractor), notice: I18n.t('views.bookings.messages.cancel')  }
	      else
	        format.html{ redirect_to request.referrer, notice: @booking.get_first_base_error }
	      end
	    end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_profile
      @profile = ProfileModel.find(params[:profile_id].nil? ? params[:booking][:profile_model_id] : params[:profile_id])
    end

    def check_if_can
      @booking ||= Booking.new
      authorize! action_name.to_s.to_sym, @booking
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:description_en, :description_es, :location_en, :location_es, :casting_date, :shooting_date, :is_direct, :status, :profile_model_id)
    end
end
