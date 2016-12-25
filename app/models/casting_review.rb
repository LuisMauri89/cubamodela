class CastingReview < ApplicationRecord

  # Associations	
  belongs_to :casting
  belongs_to :profile_contractor

  def is_valid?
  	return (casting.casting_date.to_date + 3) <= Date.today
  end
end
