class Booking < ApplicationRecord
  enum status: [:booked, :confirmed, :canceled, :rejected]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= :booked
  end

  # Validations
  validates :payment, presence: true
  validate :payment_valid
  validates :description_en, presence: true, length: { in: 20..500 }, if: :locale_en?
  validates :description_es, presence: true, length: { in: 20..500 }, if: :locale_es?
  validates :location_en, length: { in: 5..500 }, allow_blank: true, if: :locale_en?
  validates :location_es, length: { in: 5..500 }, allow_blank: true, if: :locale_es?
  validates :casting_date, presence: true
  validates :shooting_date, presence: true
  validate :casting_date_cannot_be_in_the_past, if: :no_direct_casting?
  validate :shooting_date_cannot_be_in_the_past
  validate :both_fields_blank_en_es

  # Associations
  belongs_to :profile_contractor
  belongs_to :profile_model
  has_many :chat_messages, -> { where parent: nil }, as: :ownerable, dependent: :destroy


  # Direct booking
  before_validation :check_if_direct

  # Locale
  before_save :set_description_locale, if: :new_record?
  before_save :set_location_locale, if: :new_record?

  # Scopes
  scope :valids, -> { where(status: ["booked", "confirmed"]).where("casting_date > :today", today: Time.current) }
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
  def payment_valid
    if is_string_integer?(payment)
      errors.add(:payment, :min_payment_per_model) if payment.to_i < Constant::CASTING_MIN_PAYMENT_PER_MODEL_VALUE
    else
      errors.add(:payment, :wrong_payment_per_model) if payment != Constant::CASTING_NO_PAYMENT_PER_MODEL_TEXT
    end
  end

  def casting_date_cannot_be_in_the_past
    if casting_date.present? && casting_date < Time.current
      errors.add(:casting_date, :wrong_casting_date)
    end
  end

  def shooting_date_cannot_be_in_the_past
    if shooting_date.present? && (shooting_date < Time.current || shooting_date < casting_date)
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

  def no_direct_casting?
    return !self.is_direct
  end

  # Get attrs

  def description_present
    if self.description_en.present?
      return self.description_en[0..20]
    else
      return self.description_es[0..20]
    end
  end

  def description
    case I18n.locale
    when "en".to_sym
      return self.description_en
    when "es".to_sym
      return self.description_es
    end
  end

  def location
    case I18n.locale
    when "en".to_sym
      return self.location_en
    when "es".to_sym
      return self.location_es
    end
  end

  # For expiration
  def expired?
  	return self.casting_date < Time.current
  end

  def try_confirm!
    case self.status
    when "canceled"
      errors[:base]  << I18n.t('views.bookings.messages.edit.canceled')
    when "confirmed"
      errors[:base]  << I18n.t('views.bookings.messages.edit.confirmed')
    when "booked"
      if self.casting_date <= Time.current
        errors[:base]  << I18n.t('views.bookings.messages.edit.past')
      else
        self.confirmed!
      end
    when "rejected"
      errors[:base]  << I18n.t('views.bookings.messages.edit.rejected')
    end
  end

  def try_reject!
    case self.status
    when "canceled"
      errors[:base]  << I18n.t('views.bookings.messages.edit.canceled')
    when "confirmed"
      if self.casting_date <= Time.current
        errors[:base]  << I18n.t('views.bookings.messages.edit.past')
      else
        self.rejected!
      end
    when "booked"
      if self.casting_date <= Time.current
        errors[:base]  << I18n.t('views.bookings.messages.edit.past')
      else
        self.rejected!
      end
    when "rejected"
      errors[:base]  << I18n.t('views.bookings.messages.edit.rejected')
    end
  end

  def try_cancel!
  	case self.status
    when "canceled"
      errors[:base]  << I18n.t('views.bookings.messages.edit.canceled')
    when "rejected"
      errors[:base]  << I18n.t('views.bookings.messages.edit.rejected')
    else
      if self.casting_date <= Time.current
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
    fields = fields_change?(old_booking)
    dates = dates_change?(old_booking)
    translations = translations_change?(old_booking)

    if fields && dates
      BookingChangeFieldsAndDatesJob.perform_later(self)
    elsif fields
      BookingChangeFieldsOnlyJob.perform_later(self)
    elsif dates
      BookingChangeDatesOnlyJob.perform_later(self)
    elsif translations
      BookingTranslationJob.perform_later(self)
    end
  end

  def fields_change?(old_booking)
    changes = false

    if old_booking.description_en.present?
      if old_booking.description_en != self.description_en
        self.description_es = Constant::ES_TRANSLATION_PENDING
        changes = true
      end
    else
      if old_booking.description_es != self.description_es
        self.description_en = Constant::EN_TRANSLATION_PENDING
        changes = true
      end
    end

    if old_booking.location_en.present?
      if old_booking.location_en != self.location_en
        self.location_es = Constant::ES_TRANSLATION_PENDING
        changes = true
      end
    else
      if old_booking.location_es != self.location_es
        self.location_en = Constant::EN_TRANSLATION_PENDING
        changes = true
      end
    end

    save

    return changes
  end

  def dates_change?(old_booking)
    changes = false

    if old_booking.expiration_date != self.expiration_date || old_booking.casting_date != self.casting_date || old_booking.shooting_date != self.shooting_date
      changes = true
    end

    return changes
  end

  def translations_change?(old_booking)
    changes = false

    if old_booking.description_en.present?
      if old_booking.description_en == self.description_en && self.description_es != Constant::ES_TRANSLATION_PENDING
        changes = true
      end
    else
      if old_booking.description_es == self.description_es && self.description_en != Constant::EN_TRANSLATION_PENDING
        changes = true
      end
    end

    if old_booking.location_en.present?
      if old_booking.location_en == self.location_en && self.location_es != Constant::ES_TRANSLATION_PENDING
        changes = true
      end
    else
      if old_booking.location_es == self.location_es && self.location_en != Constant::EN_TRANSLATION_PENDING
        changes = true
      end
    end

    return changes
  end

  def update_requires_charge(old_booking)
    charge_on_dates_change = false

    if old_booking.expiration_date != self.expiration_date || old_booking.casting_date != self.casting_date || old_booking.shooting_date != self.shooting_date
      if ((Time.current - self.created_at.to_date) * 24) > 24
        charge_on_dates_change = true
      end
    end

    return charge_on_dates_change
  end

  def dates_changes_without_action?
    begin
      old_booking = Casting.find(self.id)
      return !new_record? && (old_booking.expiration_date != self.expiration_date || old_booking.casting_date != self.casting_date || old_booking.shooting_date != self.shooting_date)
    rescue
      return false
    end
  end

  def translated?
    return self.description_en != Constant::EN_TRANSLATION_PENDING && 
           self.location_en != Constant::EN_TRANSLATION_PENDING &&
           self.description_es != Constant::ES_TRANSLATION_PENDING &&
           self.location_es != Constant::ES_TRANSLATION_PENDING
  end

  def is_string_integer?(str)
    true if Integer(str) rescue false
  end
end
