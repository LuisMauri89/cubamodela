class Message < ApplicationRecord
  # Status
  enum template: [:unset, :inbox_message_casting_invitation, :inbox_message_casting_changed, :inbox_message_booking_invitation, :inbox_message_booking_changed, :inbox_message_profile_published, :inbox_message_profile_unpublished]

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
    when "inbox_message_casting_changed"
      self.title = "views.messages.index.templates.casting_changed.title"
      self.description = "views.messages.index.templates.casting_changed.description"
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
  	end
  end

  # Associations
  belongs_to :ownerable, polymorphic: true
  belongs_to :asociateable, polymorphic: true
end
