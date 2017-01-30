class Message < ApplicationRecord
  # Status
  enum template: [:unset, 
                  :inbox_message_casting_new_free, 
                  :inbox_message_casting_translation, 
                  :inbox_message_casting_change_fields_only, 
                  :inbox_message_casting_change_dates_only, 
                  :inbox_message_casting_change_fields_and_dates, 
                  :inbox_message_casting_expiration_proximity, 
                  :inbox_message_casting_expired, 
                  :inbox_message_casting_canceled, 
                  :inbox_message_casting_invitation, 
                  :inbox_message_casting_invitation_confirmed, 
                  :inbox_message_casting_application, 
                  :inbox_message_casting_application_confirmed, 
                  :inbox_message_booking_invitation, 
                  :inbox_message_booking_confirmed, 
                  :inbox_message_booking_rejected, 
                  :inbox_message_booking_canceled, 
                  :inbox_message_booking_translation, 
                  :inbox_message_booking_change_fields_only, 
                  :inbox_message_booking_change_dates_only, 
                  :inbox_message_booking_change_fields_and_dates, 
                  :inbox_message_booking_left_review, 
                  :inbox_message_profile_published, 
                  :inbox_message_profile_unpublished, 
                  :inbox_message_profile_reject, 
                  :inbox_message_profile_warning, 
                  :inbox_message_review_new,
                  :inbox_message_coupon_sent,
                  :inbox_message_custom_send]

  after_initialize :set_default_template, if: :new_record?

  def set_default_template
  	self.template ||= :unset
  end

  before_save :set_title_and_desc, if: :new_record?

  def set_title_and_desc
  	case self.template
  	when "inbox_message_casting_new_free"
  		self.title = "views.messages.index.templates.casting_new_free.title"
  		self.description = "views.messages.index.templates.casting_new_free.description"
    when "inbox_message_casting_translation"
      self.title = "views.messages.index.templates.casting_translation.title"
      self.description = "views.messages.index.templates.casting_translation.description"
    when "inbox_message_casting_change_fields_only"
      self.title = "views.messages.index.templates.casting_change_fields_only.title"
      self.description = "views.messages.index.templates.casting_change_fields_only.description"
    when "inbox_message_casting_change_dates_only"
      self.title = "views.messages.index.templates.casting_change_dates_only.title"
      self.description = "views.messages.index.templates.casting_change_dates_only.description"
    when ":inbox_message_casting_change_fields_and_dates"
      self.title = "views.messages.index.templates.casting_change_fields_and_dates.title"
      self.description = "views.messages.index.templates.casting_change_fields_and_dates.description"
    when "inbox_message_casting_expiration_proximity"
      self.title = "views.messages.index.templates.casting_expiration_proximity.title"
      self.description = "views.messages.index.templates.casting_expiration_proximity.description"
    when "inbox_message_casting_expired"
      self.title = "views.messages.index.templates.casting_expired.title"
      self.description = "views.messages.index.templates.casting_expired.description"
    when "inbox_message_casting_canceled"
      self.title = "views.messages.index.templates.casting_canceled.title"
      self.description = "views.messages.index.templates.casting_canceled.description"
    when "inbox_message_casting_invitation"
      self.title = "views.messages.index.templates.casting_invitation.title"
      self.description = "views.messages.index.templates.casting_invitation.description"
    when "inbox_message_casting_invitation_confirmed"
      self.title = "views.messages.index.templates.casting_invitation_confirmed.title"
      self.description = "views.messages.index.templates.casting_invitation_confirmed.description"
    when "inbox_message_casting_application"
      self.title = "views.messages.index.templates.casting_application.title"
      self.description = "views.messages.index.templates.casting_application.description"
    when "inbox_message_casting_application_confirmed"
      self.title = "views.messages.index.templates.casting_application_confirmed.title"
      self.description = "views.messages.index.templates.casting_application_confirmed.description"
    when "inbox_message_booking_invitation"
      self.title = "views.messages.index.templates.booking_invitation.title"
      self.description = "views.messages.index.templates.booking_invitation.description"
    when "inbox_message_booking_confirmed"
      self.title = "views.messages.index.templates.booking_confirmed.title"
      self.description = "views.messages.index.templates.booking_confirmed.description"
    when "inbox_message_booking_rejected"
      self.title = "views.messages.index.templates.booking_rejected.title"
      self.description = "views.messages.index.templates.booking_rejected.description"
    when "inbox_message_booking_canceled"
      self.title = "views.messages.index.templates.booking_canceled.title"
      self.description = "views.messages.index.templates.booking_canceled.description"
    when "inbox_message_booking_translation"
      self.title = "views.messages.index.templates.booking_translation.title"
      self.description = "views.messages.index.templates.booking_translation.description"
    when "inbox_message_booking_change_fields_only"
      self.title = "views.messages.index.templates.booking_change_fields_only.title"
      self.description = "views.messages.index.templates.booking_change_fields_only.description"
    when "inbox_message_booking_change_dates_only"
      self.title = "views.messages.index.templates.booking_change_dates_only.title"
      self.description = "views.messages.index.templates.booking_change_dates_only.description"
    when "inbox_message_booking_change_fields_and_dates"
      self.title = "views.messages.index.templates.booking_change_fields_and_dates.title"
      self.description = "views.messages.index.templates.booking_change_fields_and_dates.description"
    when "inbox_message_booking_left_review"
      self.title = "views.messages.index.templates.booking_left_review.title"
      self.description = "views.messages.index.templates.booking_left_review.description"
    when "inbox_message_profile_published"
      self.title = "views.messages.index.templates.profile_published.title"
      self.description = "views.messages.index.templates.profile_published.description"
    when "inbox_message_profile_unpublished"
      self.title = "views.messages.index.templates.profile_unpublished.title"
      self.description = "views.messages.index.templates.profile_unpublished.description"
    when "inbox_message_profile_reject"
      self.title = "views.messages.index.templates.profile_reject.title"
      self.description = "views.messages.index.templates.profile_reject.description"
    when "inbox_message_profile_warning"
      self.title = "views.messages.index.templates.profile_warning.title"
      self.description = "views.messages.index.templates.profile_warning.description"
    when "inbox_message_review_new"
      self.title = "views.messages.index.templates.review_new.title"
      self.description = "views.messages.index.templates.review_new.description"
    when "inbox_message_coupon_sent"
      self.title = "views.messages.index.templates.coupon_sent.title"
      self.description = "views.messages.index.templates.coupon_sent.description"
    when "inbox_message_custom_send"
      self.title = "views.messages.index.templates.message_custom_send.title"
      self.description = "views.messages.index.templates.message_custom_send.description"
    end
  end

  # Associations
  belongs_to :ownerable, polymorphic: true
  belongs_to :asociateable, polymorphic: true, optional: true
  belongs_to :thirdable, polymorphic: true, optional: true
end
