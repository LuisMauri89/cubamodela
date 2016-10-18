class Booking < ApplicationRecord
  enum status: [:booked, :confirmed, :canceled]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= :booked
  end

  # Validations
  validates :description, presence: true, length: { in: 20..500 }
  validates :location, length: { in: 5..500 }, allow_blank: true
  validate :casting_date_cannot_be_in_the_past
  validate :shooting_date_cannot_be_in_the_past

  # Associations
  belongs_to :profile_contractor
  belongs_to :profile_model

  # Custom Validators
  def casting_date_cannot_be_in_the_past
    if casting_date.present? && casting_date < Date.today
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
  	return casting_date < Date.today
  end

  def confirm_model
    if self.canceled? || self.casting_date <= Date.today
      errors[:base] << "can't operate on a old booking or canceled."
    else
      self.confirmed!
    end
  end

  def cancel!
  	if self.canceled? || self.casting_date <= Date.today
      errors[:base] << "can't operate on a old booking or canceled."
    else
      self.canceled!
    end
  end
end
