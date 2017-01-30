class CastingReview < ApplicationRecord

  # Associations	
  belongs_to :casting
  belongs_to :profile_contractor

  def is_valid?
  	return (casting.casting_date.to_date + 3) <= Date.today
  end

  def do_not_show_again
  	self.show_again = false
  	save
  end
end
