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
                  :inbox_message_review_new]

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
  end

  # Associations
  belongs_to :ownerable, polymorphic: true
  belongs_to :asociateable, polymorphic: true, optional: true
  belongs_to :thirdable, polymorphic: true, optional: true
end
