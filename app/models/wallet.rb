class Wallet < ApplicationRecord
  # Status
  enum status: [:active, :frized]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
  	self.status ||= :active
  end

  # Associations	
  belongs_to :ownerable, polymorphic: true

  def use_coupon(value)
  	# value = value.trim //ver como remover espacios al inicio y final
  	coupon = Coupon.actives.where(code: value).first

  	if coupon != nil
	  	self.amount += coupon.amount
	  	coupon.use!
	  	CouponCharge.create(coupon: coupon, wallet: self)
	  	return save
  	else
  		return false
  	end
  end
end
