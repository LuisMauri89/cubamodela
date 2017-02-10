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

	def get_payment_collection
	    collection = [[t('activerecord.attributes.casting.payment_per_model_options.select'), 'white']]
	    # collection << [t('activerecord.attributes.casting.payment_per_model_options.tfp'), 'TFP']
	    get_values_on_step(6, 25, 22, 100, collection)

	    return collection
	end

	def get_values_on_step(min_step_count, min_step, max_step_count, max_step, collection)
		min_value = Constant::CASTING_MIN_PAYMENT_PER_MODEL_VALUE

		(0..min_step_count).each do |step|
			collection << [(min_value + (min_step*step)).to_s, (min_value + (min_step*step)).to_s]
		end

		min_value = collection[collection.length - 1][0].to_i

		(1..max_step_count).each do |step|
			collection << [(min_value + (max_step*step)).to_s, (min_value + (max_step*step)).to_s]
		end
	end
end
