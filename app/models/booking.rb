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
  validate :casting_date_cannot_be_in_the_past, if: :no_direct_casting
  validate :shooting_date_cannot_be_in_the_past
  validate :both_fields_blank_en_es

  # Associations
  belongs_to :profile_contractor
  belongs_to :profile_model


  # Direct booking
  before_validation :check_if_direct

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
      errors.add(:casting_date, :wrong_casting_date)
    end
  end

  def shooting_date_cannot_be_in_the_past
    if shooting_date.present? && (shooting_date < Date.today || shooting_date <= casting_date)
      errors.add(:shooting_date, :wrong_shooting_date)
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

  def check_if_direct
    if self.is_direct
      self.casting_date = self.shooting_date
    end
  end

  def locale_en?
    return I18n.locale == "en".to_sym
  end

  def locale_es?
    return I18n.locale == "es".to_sym
  end

  def no_direct_casting
    return !self.is_direct
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
  	return self.casting_date < DateTime.now
  end

  def try_confirm!
    case self.status
    when "canceled"
      errors[:base]  << I18n.t('views.bookings.messages.edit.canceled')
    when "confirmed"
      errors[:base]  << I18n.t('views.bookings.messages.edit.confirmed')
    when "booked"
      if self.casting_date <= DateTime.now
        errors[:base]  << I18n.t('views.bookings.messages.edit.past')
      else
        self.confirmed!
      end
    end
  end

  def try_cancel!
  	if self.canceled? || self.casting_date <= Date.today
      errors[:base] << "can't operate on a old booking or canceled."
    else
      self.canceled!
    end

    case self.status
    when "canceled"
      errors[:base]  << I18n.t('views.bookings.messages.edit.canceled')
    else
      if self.casting_date <= DateTime.now
        errors[:base]  << I18n.t('views.bookings.messages.edit.past')
      else
        self.canceled!
      end
    end
  end

  def get_first_base_error
    if errors[:base].any?
      return errors[:base][0]
    else
      return ""
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
