class Booking < ApplicationRecord
  enum status: [:booked, :confirmed, :canceled]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= :booked
  end

  # Validations
  validates :description_en, presence: true, length: { in: 20..500 }, if: :locale_en?
  validates :description_es, presence: true, length: { in: 20..500 }, if: :locale_es?
  validates :location_en, length: { in: 5..500 }, allow_blank: true, if: :locale_en?
  validates :location_es, length: { in: 5..500 }, allow_blank: true, if: :locale_es?
  validate :casting_date_cannot_be_in_the_past, :shooting_date_cannot_be_in_the_past
  validate :both_fields_blank_en_es

  # Associations
  belongs_to :profile_contractor
  belongs_to :profile_model

  # Locale
  before_save :set_description_locale, if: :new_record?
  before_save :set_location_locale, if: :new_record?

  # Scopes
  scope :valids, -> { where(status: ["booked", "confirmed"]).where("casting_date > :today", today: DateTime.now) }
  scope :valid_bookings, -> { valids.order("created_at DESC") }
  scope :description_needs_translation, -> { valids.where(description_en: Constant::EN_TRANSLATION_PENDING).or(self.valids.where(description_es: Constant::ES_TRANSLATION_PENDING)) }
  scope :location_needs_translation, -> { valids.where(location_en: Constant::EN_TRANSLATION_PENDING).or(self.valids.where(location_es: Constant::ES_TRANSLATION_PENDING)) }
  scope :needs_translation, -> { description_needs_translation.or(self.location_needs_translation).order("created_at ASC") }

  def set_description_locale
    if I18n.locale == "en".to_sym
      self.description_es ||= Constant::ES_TRANSLATION_PENDING
    else
      self.description_en ||= Constant::EN_TRANSLATION_PENDING
    end
  end

  def set_location_locale
    if I18n.locale == "en".to_sym
      self.location_es ||= Constant::ES_TRANSLATION_PENDING
    else
      self.location_es ||= Constant::EN_TRANSLATION_PENDING
    end
  end

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

  def both_fields_blank_en_es
    if !self.description_en.present? && !self.description_es.present?
      errors.add(:description_en, :blank)
      errors.add(:description_es, :blank)
    end

    if !self.location_en.present? && !self.location_es.present?
      errors.add(:location_en, :blank)
      errors.add(:location_es, :blank)
    end
  end

  def locale_en?
    return I18n.locale == "en".to_sym
  end

  def locale_es?
    return I18n.locale == "es".to_sym
  end

  def description_present
    if self.description_en.present?
      return self.description_en[20]
    else
      return self.description_es[20]
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

  def send_update_notification(old_booking)
    if old_booking.casting_date != casting_date || old_booking.shooting_date != shooting_date
      BookingDatesChangedJob.perform_later(self)
    end

    check_translated_fields_changes(old_booking)
  end

  def send_translation_notification(old_booking)
    if !old_booking.translated? && translated? 
      NewBookingJob.perform_later(self)
    end
  end

  def translated?
    return self.description_en != Constant::EN_TRANSLATION_PENDING && 
           self.location_en != Constant::EN_TRANSLATION_PENDING &&
           self.description_es != Constant::ES_TRANSLATION_PENDING &&
           self.location_es != Constant::ES_TRANSLATION_PENDING
  end

  def check_translated_fields_changes(old_booking)

    if old_booking.description_en.present?
      if old_booking.description_en != self.description_en
        self.description_es = Constant::ES_TRANSLATION_PENDING
      end
    else
      if old_booking.description_es != self.description_es
        self.description_en = Constant::EN_TRANSLATION_PENDING
      end
    end

    if old_booking.location_en.present?
      if old_booking.location_en != self.location_en
        self.location_es = Constant::ES_TRANSLATION_PENDING
      end
    else
      if old_booking.location_es != self.location_es
        self.location_en = Constant::EN_TRANSLATION_PENDING
      end
    end

    save
  end
end
