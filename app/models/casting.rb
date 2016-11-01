class Casting < ApplicationRecord
  # Status
  enum status: [:active, :closed, :canceled]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
  	self.status ||= :active
  end

  # Access Type
  enum access_type: [:free, :personal]

  after_initialize :set_default_access_type, if: :new_record?

  def set_default_access_type
    self.access_type ||= :free
  end

  # Validations
  validates :title, presence: true, length: { in: 3..50 }
  validates :description, presence: true, length: { in: 20..500 }
  validates :location, length: { in: 5..500 }, allow_blank: true
  validate :expiration_date_cannot_be_in_the_past
  validate :casting_date_cannot_be_in_the_past
  validate :shooting_date_cannot_be_in_the_past
  validates :access_type, inclusion: { in: %w(free personal) }

  #Scopes
  scope :actives, lambda { where(status: "active").order("created_at DESC") }

  # Associations	
  belongs_to :ownerable, polymorphic: true
  has_many :intents, dependent: :destroy
  has_many :profile_models, through: :intents
  has_many :photos, as: :attachable, dependent: :destroy
  has_and_belongs_to_many :modalities, dependent: :destroy

  # Custom Validators
  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past.")
    end
  end

  def casting_date_cannot_be_in_the_past
    if casting_date.present? && (casting_date < Date.today || casting_date <= expiration_date)
      errors.add(:casting_date, "can't be in the past or before the expliration date.")
    end
  end

  def shooting_date_cannot_be_in_the_past
    if shooting_date.present? && (shooting_date < Date.today || shooting_date <= casting_date)
      errors.add(:shooting_date, "can't be in the past or before the casting date.")
    end
  end

  # For expiration
  def expired?
  	return expiration_date < Date.today
  end

  def close
  	self.closed!
  end

  def close!
  	if self.expired? && not(self.canceled?)
  		self.closed!
  	else
  		errors[:base] << "The casting can't be closed because is eather not expired or already canceled."
  	end
  end

  def activate!
    if not(self.canceled?)
      self.expiration_date = Date.today + 10
      self.casting_date = Date.today + 15
      self.shooting_date = Date.today + 20
      self.active!
    else
      errors[:base] << "The casting can't be activated because it has been canceled."
    end
  end

  def cancel!
  	if not(self.closed?)
  		self.canceled!
  	else
  		errors[:base] << "The casting can't be canceled because it has expired"
  	end
  end

  def force_close!
  	if not(self.canceled?)
  		self.expiration_date = Date.today
  		self.closed!
  	else
  		errors[:base] << "The casting can't be closed because it has been canceled."
  	end
  end

  def get_first_references_photo
    return photos.first
  end

  def get_rest_references_photo
    return photos.offset(1).limit(4)
  end

  def invite_model(profile)
    if self.canceled? || self.casting_date <= Date.today
      return invalid_intent
    else
      intent = Intent.new(casting: self, profile_model: profile, status: "invited")

      return intent
    end
  end

  def confirm_model(profile)
    if self.canceled? || self.casting_date <= Date.today
      return invalid_intent
    else
      intent = Intent.where(profile_model_id: profile.id).first
      intent ||= Intent.new
      intent.confirmed!

      if intent.new_record?
        intent.errors[:base] << "can't confirm without invitation."
      end

      return intent
    end
  end

  def apply_model(profile)
    if self.personal? || self.closed? || self.canceled? || self.casting_date <= Date.today || not(profile.can_apply?(self))
      return invalid_intent
    else
      intent = Intent.where(profile_model_id: profile.id).first
      intent ||= Intent.new(casting: self, profile_model: profile, status: "applied")

      if not(intent.new_record?)
        intent.errors[:base] << "can't applied for casting you already in."
      end

      return intent
    end
  end

  def invalid_intent
    intent = Intent.new
    intent.errors[:base] << "can't operate on a old casting or canceled or private or already applied."

    return intent
  end
end
