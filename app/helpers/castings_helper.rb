module CastingsHelper
	def get_days_for_expiration(expiration_date)
		# return "In " << pluralize((Date.today - expiration_date).days, "day")
		return "In " << pluralize(4, "day")
	end
end
