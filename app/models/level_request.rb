class LevelRequest < ApplicationRecord

  # Level
  enum level: [:unset, :professional_model]

  after_initialize :set_default_level, if: :new_record?

  def set_default_level
	self.level ||= :unset
  end

  # Associations	
  belongs_to :requester, polymorphic: true

  # Scope
  scope :model_requests, -> { where(level: "professional_model").order("created_at ASC") }

  def accept
  	if self.requester.can_upgrade_level?
  		self.requester.upgrade_level
  		return self.requester.save
  	end

    return false
  end
end
