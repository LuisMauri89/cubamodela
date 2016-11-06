class Intent < ApplicationRecord
  # Validations
  validates :casting_id, uniqueness: { scope: :profile_model_id,
    message: :invited }

  # Status
  enum status: [:unset, :applied, :invited, :confirmed, :denied, :canceled]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
  	self.status ||= :unset
  end

  #Scopes
  scope :models_invited, lambda { where(status: "invited").order("created_at DESC") }
  scope :models_confirmed, lambda { where(status: "confirmed").order("created_at DESC") }
  scope :models_applied, lambda { where(status: "applied").order("created_at DESC") }

  # Associations
  belongs_to :profile_model
  belongs_to :casting

  # Methods

  def get_first_base_error
    if errors[:base].any?
      return errors[:base][0]
    else
      return ""
    end
  end
end
