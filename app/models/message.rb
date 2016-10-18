class Message < ApplicationRecord
  # Status
  enum template: [:unset, :inbox_message_casting_invitation, :inbox_message_booking_invitation]

  after_initialize :set_default_template, if: :new_record?

  def set_default_template
  	self.template ||= :unset
  end

  before_save :set_title_and_desc, if: :new_record?

  def set_title_and_desc
  	case self.template
  	when "inbox_message_casting_invitation"
  		self.title = "New Invitation"
  		self.description = "You have been invited to a new casting"
    when "inbox_message_booking_invitation"
      self.title = "New Booking"
      self.description = "You have been booked"
  	end
  end

  # Associations
  belongs_to :ownerable, polymorphic: true
  belongs_to :asociateable, polymorphic: true
end
