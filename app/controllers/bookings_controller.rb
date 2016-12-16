class BookingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_booking, only: [:show, :edit, :translate, :cancel, :update, :confirm, :destroy]
	before_action :set_profile, only: [:new, :create, :edit, :update, :confirm]
	before_action :check_if_can, only: [:edit, :update, :destroy, :index_custom_contractor, :index_custom_model, :confirm, :cancel]

	def index_custom_contractor
		@contractor = ProfileContractor.find(params[:contractor_id])

		@bookings = @contractor.valid_bookings.order("created_at DESC")
	end

	def index_custom_model
		@model = ProfileModel.find(params[:model_id])

		@bookings = @model.valid_bookings.order("created_at DESC")
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
	  		if @booking.save
	  			Message.create(template: "inbox_message_booking_invitation", ownerable: @booking.profile_model, asociateable: @booking)
        		format.html { redirect_to custom_index_contractor_bookings_path(@booking.profile_contractor), notice: I18n.t('views.bookings.messages.create') }
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
	      if @booking.update(booking_params)

	      	@booking.send_update_notification(old_booking)
        	@booking.send_translation_notification(old_booking)

	        format.html { redirect_to custom_index_contractor_bookings_path(@booking.profile_contractor), notice: I18n.t('views.bookings.messages.update') }
	      else
	        format.html { render :edit }
	      end
	    end
	end

	def confirm
	    @booking.try_confirm!

	    respond_to do |format|
	      if @booking.save
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
	        format.html{ redirect_to custom_index_contractor_bookings(@booking.profile_contractor), notice: I18n.t('views.bookings.messages.cancel')  }
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
