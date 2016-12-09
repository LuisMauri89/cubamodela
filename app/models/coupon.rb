class Coupon < ApplicationRecord
  # Status
  enum status: [:active, :used]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
  	self.status ||= :active
  end

  # Scopes
  scope :actives, -> { where(status: "active") }

  def use!
  	used!
  	save
  end
end
