class BookingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_booking, only: [:show, :edit, :translate, :update, :confirm, :destroy]
	before_action :set_profile, only: [:new, :create, :edit, :update, :confirm]
	before_action :check_if_can, only: [:edit, :update, :destroy]

	def index_custom
		@bookings = current_user.profileable.bookings.order("created_at DESC")
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
        		format.html { redirect_to custom_index_bookings_path, notice: 'Booking successfully.' }
	  		else
	  			format.html { render :new }
	  		end
	  	end
	end

	def edit
	  	if @booking.expired?
	  		redirect_to custom_index_bookings_path, notice: '!!!SORRY this booking has expired.'
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

	        format.html { redirect_to custom_index_bookings_path, notice: 'Booking was successfully updated.' }
	      else
	        format.html { render :edit }
	      end
	    end
	end

	def confirm
	    @booking.confirm_model

	    respond_to do |format|
	      if @booking.save
	        format.js
	      else
	        format.js
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
      authorize! action_name.to_s.to_sym, @booking
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:description, :location, :casting_date, :shooting_date, :status, :profile_model_id)
    end
end
