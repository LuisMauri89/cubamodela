class CouponsController < ApplicationController

	def index
		@coupons = Coupon.actives
	end

	def charge_coupon
		first = coupon_params[:first]
		second = coupon_params[:second]
		third = coupon_params[:third]

		coupon = first << second << third
		@coupon_charged = false

		respond_to do |format|
			if current_user.profileable.wallet.use_coupon(coupon)
				used_coupon = Coupon.where(code: coupon).first
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
end
