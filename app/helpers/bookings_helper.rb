module BookingsHelper
	def get_confirmed_class(booking)
		return booking.confirmed? ? "bg-success" : ""
	end
end
