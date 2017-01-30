module BookingsHelper
	def get_confirmed_class(booking)
		return booking.confirmed? ? "confirmed-bkg" : ""
	end

	def get_show_hide_style(is_direct)
		if is_direct
			return "style=display:none;"
		else
			return ""
		end
	end
end
