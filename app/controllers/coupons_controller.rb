class CouponsController < ApplicationController

	def index
		@coupons = Coupon.all

		values = ["to", "za", "pa"]
		values_taken = [false, false, false]
		@combinations = go_ahead("", values, values_taken)
	end

	def charge_coupon
		first = coupon_params[:first]
		second = coupon_params[:second]
		third = coupon_params[:third]

		coupon = first << second << third
		@coupon_charged = false

		respond_to do |format|
			if current_user.profileable.wallet.use_coupon(coupon)

				used_coupon = Coupon.useds.where(code: coupon).first
				@coupon_amount = CouponCharge.where(coupon_id: used_coupon.id).last.wallet.amount
				@coupon_charged = true

				format.js
			else
				format.js
			end
		end
	end

	private
		def coupon_params
	      params.require(:values).permit(:first, :second, :third)
	    end

	    def go_ahead(word, values, values_taken)
	    	if values_taken.select{|v| !v}.length == 1
	    		index = get_index(values_taken)
	    		word = word + "-" + values[index]
	    		@combinations ||= Array.new
	    		@combinations << word
	    		return @combinations
	    	else
	    		for i in (0..(values.length - 1))
	    			if values_taken[i] == false
	    				word_left = word.clone
		    			if word_left == ""
		    				word_left = word_left + values[i]
		    			else
		    				word_left = word_left + "-" + values[i]
		    			end
		    			values_taken[i] = true
		    			@combinations = go_ahead(word_left, values, values_taken)
		    			values_taken[i] = false
	    			end
	    		end
	    		return @combinations
	    	end
	    end

	    def get_index(values_taken)
	    	values_taken.each_with_index do |value, index|
	    		if value == false
	    			return index
	    		end
	    	end
	    end
end
