# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview
	def email_booking_invitation
		BookingMailer.email_booking_invitation(ProfileModel.find(45), Booking.first)
	end

	def email_booking_confirmed
		BookingMailer.email_booking_confirmed(ProfileContractor.find(2), Booking.first, ProfileModel.find(45))
	end

	def email_booking_rejected
		BookingMailer.email_booking_rejected(ProfileContractor.find(2), Booking.first, ProfileModel.find(45))
	end

	def email_booking_canceled
		BookingMailer.email_booking_canceled(ProfileModel.find(45), Booking.first)
	end

	def email_booking_translation
		BookingMailer.email_booking_translation(ProfileModel.find(45), Booking.first)
	end

	def email_booking_change_fields_only
		BookingMailer.email_booking_change_fields_only(ProfileModel.find(45), Booking.first)
	end

	def email_booking_change_dates_only
		BookingMailer.email_booking_change_dates_only(ProfileModel.find(45), Booking.first)
	end

	def email_booking_change_fields_and_dates
		BookingMailer.email_booking_change_fields_and_dates(ProfileModel.find(45), Booking.first)
	end

	def email_booking_invitation
		BookingMailer.email_booking_invitation(ProfileModel.find(45), Booking.first)
	end
end
