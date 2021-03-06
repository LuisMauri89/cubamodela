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
  	value = value.strip
  	coupon = Coupon.givens.where(code: value).first

  	if coupon != nil
	  	self.amount += coupon.amount
	  	coupon.use!
	  	CouponCharge.create(coupon: coupon, wallet: self)
	  	return save
  	else
  		return false
  	end
  end

  def charge(amount)
    if self.active?
      self.amount -= amount
      return save 
    end

    return false
  end
end
