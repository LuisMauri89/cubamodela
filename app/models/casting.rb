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

  # Action methods on casting

  def get_first_base_error
    if errors[:base].any?
      return errors[:base][0]
    else
      return ""
    end
  end

  def expired?
    return expiration_date < Date.today
  end

  def allow_edit?
    case status
    when "active"
      return nil
    when "closed"
      if Date.today < casting_date
        return nil
      else
        return I18n.t('views.castings.messages.edit.past')
      end
    when "canceled"
      return I18n.t('views.castings.messages.edit.canceled')
    end
  end

  def try_close!
    case status
    when "active"
      expiration_date = Date.today
      closed!
    when "closed"
      errors[:base] << I18n.t('views.castings.messages.edit.closed')
    when "canceled"
      errors[:base] << I18n.t('views.castings.messages.edit.canceled')
    end
  end

  def try_cancel!
    case status
    when "active"
      canceled!
    when "closed"
      if Date.today < casting_date
        canceled!
      else
        errors[:base] << I18n.t('views.castings.messages.edit.past')
      end
    when "canceled"
      errors[:base] << I18n.t('views.castings.messages.edit.canceled')
    end
  end

  def try_activate!
    case status
    when "active"
      errors[:base] << I18n.t('views.castings.messages.edit.active')
    when "closed"
      if Date.today < casting_date
        expiration_date = Date.today + 1
        casting_date = casting_date + 1
        shooting_date = shooting_date + 1
        active!
      else
        errors[:base] << I18n.t('views.castings.messages.edit.past')
      end
    when "canceled"
      errors[:base] << I18n.t('views.castings.messages.edit.canceled')
    end
  end

  def get_first_references_photo
    return photos.first
  end

  def get_rest_references_photo
    return photos.offset(1).limit(4)
  end

  def try_invite!(profile)
    intent = Intent.new

    case status
    when "active"
      intent.update(casting: self, profile_model: profile, status: "invited")
    when "closed"
      if Date.today < casting_date
        intent.update(casting: self, profile_model: profile, status: "invited")
      else
        intent.errors[:base] << I18n.t('views.castings.messages.edit.past')
      end
    when "canceled"
      intent.errors[:base] << I18n.t('views.castings.messages.edit.canceled')
    end

    return intent
  end

  def try_confirm!(profile)
    intent = Intent.where(profile_model_id: profile.id).first
    intent ||= Intent.new

    if intent.new_record?
      intent.errors[:base] << I18n.t('views.castings.messages.associations.confirmed_denied_no_intent')
    else
      case status
      when "active"
        intent.confirmed!
      when "closed"
        if Date.today < casting_date
          intent.confirmed!
        else
          intent.errors[:base] << I18n.t('views.castings.messages.edit.past')
        end
      when "canceled"
        intent.errors[:base] << I18n.t('views.castings.messages.edit.canceled')
      end
    end

    return intent
  end

  def try_apply!(profile)
    intent = Intent.new

    case status
    when "active"
      if free?
        intent.update(casting: self, profile_model: profile, status: "applied")
      else
        intent.errors[:base] << I18n.t('views.castings.messages.associations.applied_denied_personal')
      end
    when "closed"
      intent.errors[:base] << I18n.t('views.castings.messages.associations.applied_denied_closed')
    when "canceled"
      intent.errors[:base] << I18n.t('views.castings.messages.edit.canceled')
    end

    return intent
  end

  def send_update_notification(old_casting)
    if old_casting.expiration_date != expiration_date || old_casting.casting_date != casting_date || old_casting.shooting_date != shooting_date
        # call method to notify
    end
  end
end
