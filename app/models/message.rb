class Message < ApplicationRecord
  # Status
  enum template: [:unset, :inbox_message_casting_invitation, :inbox_message_casting_invited_date_proximity, :inbox_message_casting_invited_expiration_proximity, :inbox_message_casting_available_expiration_proximity, :inbox_message_casting_canceled, :inbox_message_casting_closed, :inbox_message_new_casting_free, :inbox_message_casting_application_confirmation, :inbox_message_casting_application, :inbox_message_casting_confirmation, :inbox_message_casting_dates_changed_invited, :inbox_message_casting_dates_changed_confirmed, :inbox_message_casting_dates_changed_applied, :inbox_message_booking_invitation, :inbox_message_booking_changed, :inbox_message_profile_published, :inbox_message_profile_unpublished]

  after_initialize :set_default_template, if: :new_record?

  def set_default_template
  	self.template ||= :unset
  end

  before_save :set_title_and_desc, if: :new_record?

  def set_title_and_desc
  	case self.template
  	when "inbox_message_casting_invitation"
  		self.title = "views.messages.index.templates.casting_invitation.title"
  		self.description = "views.messages.index.templates.casting_invitation.description"
    when "inbox_message_casting_confirmation"
      self.title = "views.messages.index.templates.casting_confirmation.title"
      self.description = "views.messages.index.templates.casting_confirmation.description"
    when "inbox_message_casting_application"
      self.title = "views.messages.index.templates.casting_application.title"
      self.description = "views.messages.index.templates.casting_application.description"
    when "inbox_message_casting_application_confirmation"
      self.title = "views.messages.index.templates.casting_application_confirmation.title"
      self.description = "views.messages.index.templates.casting_application_confirmation.description"
    when "inbox_message_new_casting_free"
      self.title = "views.messages.index.templates.new_casting_free.title"
      self.description = "views.messages.index.templates.new_casting_free.description"
    when "inbox_message_casting_closed"
      self.title = "views.messages.index.templates.casting_closed.title"
      self.description = "views.messages.index.templates.casting_closed.description"
    when "inbox_message_casting_canceled"
      self.title = "views.messages.index.templates.casting_canceled.title"
      self.description = "views.messages.index.templates.casting_canceled.description"
    when "inbox_message_casting_dates_changed_invited"
      self.title = "views.messages.index.templates.casting_dates_changed_invited.title"
      self.description = "views.messages.index.templates.casting_dates_changed_invited.description"
    when "inbox_message_casting_dates_changed_confirmed"
      self.title = "views.messages.index.templates.casting_dates_changed_confirmed.title"
      self.description = "views.messages.index.templates.casting_dates_changed_confirmed.description"
    when "inbox_message_casting_dates_changed_applied"
      self.title = "views.messages.index.templates.casting_dates_changed_applied.title"
      self.description = "views.messages.index.templates.casting_dates_changed_applied.description"
    when "inbox_message_booking_invitation"
      self.title = "views.messages.index.templates.booking_invitation.title"
      self.description = "views.messages.index.templates.booking_invitation.description"
    when "inbox_message_booking_changed"
      self.title = "views.messages.index.templates.booking_changed.title"
      self.description = "views.messages.index.templates.booking_changed.description"
    when "inbox_message_profile_published"
      self.title = "views.messages.index.templates.profile_published.title"
      self.description = "views.messages.index.templates.profile_published.description"
    when "inbox_message_profile_unpublished"
      self.title = "views.messages.index.templates.profile_unpublished.title"
      self.description = "views.messages.index.templates.profile_unpublished.description"
    when "inbox_message_casting_available_expiration_proximity"
      self.title = "views.messages.index.templates.casting_available_expiration_proximity.title"
      self.description = "views.messages.index.templates.casting_available_expiration_proximity.description"
    when "inbox_message_casting_invited_expiration_proximity"
      self.title = "views.messages.index.templates.casting_invited_expiration_proximity.title"
      self.description = "views.messages.index.templates.casting_invited_expiration_proximity.description"
    when "inbox_message_casting_invited_date_proximity"
      self.title = "views.messages.index.templates.casting_invited_date_proximity.title"
      self.description = "views.messages.index.templates.casting_invited_date_proximity.description"
    end
  end

  # Associations
  belongs_to :ownerable, polymorphic: true
  belongs_to :asociateable, polymorphic: true, optional: true
  belongs_to :thirdable, polymorphic: true, optional: true
end
