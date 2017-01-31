class CouponCharge < ApplicationRecord
  # Associations
  belongs_to :coupon
  belongs_to :wallet
end
