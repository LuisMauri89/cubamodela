class Notification

	# Notify methods

	# Casting
	def self.notify_casting_new_free(owner, asociated)
		Message.create(template: "inbox_message_casting_new_free", ownerable: owner, asociateable: asociated)
	end


	def self.notify_casting_translation(owner, asociated)
		Message.create(template: "inbox_message_casting_translation", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_change_fields_only(owner, asociated)
		Message.create(template: "inbox_message_casting_change_fields_only", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_change_dates_only(owner, asociated)
		Message.create(template: "inbox_message_casting_change_dates_only", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_change_fields_and_dates(owner, asociated)
		Message.create(template: "inbox_message_casting_change_fields_and_dates", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_expiration_proximity(owner, asociated)
		Message.create(template: "inbox_message_casting_expiration_proximity", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_expired(owner, asociated)
		Message.create(template: "inbox_message_casting_expired", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_canceled(owner, asociated)
		Message.create(template: "inbox_message_casting_canceled", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_invitation(owner, asociated)
		Message.create(template: "inbox_message_casting_invitation", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_invitation_confirmed(owner, asociated, third)
		Message.create(template: "inbox_message_casting_invitation_confirmed", ownerable: owner, asociateable: asociated, thirdable: third)
	end

	def self.notify_casting_application(owner, asociated, third)
		Message.create(template: "inbox_message_casting_application", ownerable: owner, asociateable: asociated, thirdable: third)
	end

	def self.notify_casting_application_confirmed(owner, asociated)
		Message.create(template: "inbox_message_casting_application_confirmed", ownerable: owner, asociateable: asociated)
	end

	# Booking
	def self.notify_booking_invitation(owner, asociated)
		Message.create(template: "inbox_message_booking_invitation", ownerable: owner, asociateable: asociated)
	end

	def self.notify_booking_confirmed(owner, asociated, third)
		Message.create(template: "inbox_message_booking_confirmed", ownerable: owner, asociateable: asociated, thirdable: third)
	end

	def self.notify_booking_rejected(owner, asociated, third)
		Message.create(template: "inbox_message_booking_rejected", ownerable: owner, asociateable: asociated, thirdable: third)
	end

	def self.notify_booking_canceled(owner, asociated)
		Message.create(template: "inbox_message_booking_canceled", ownerable: owner, asociateable: asociated)
	end

	def self.notify_booking_translation(owner, asociated)
		Message.create(template: "inbox_message_booking_translation", ownerable: owner, asociateable: asociated)
	end

	def self.notify_booking_change_fields_only(owner, asociated)
		Message.create(template: "inbox_message_booking_change_fields_only", ownerable: owner, asociateable: asociated)
	end

	def self.notify_booking_change_dates_only(owner, asociated)
		Message.create(template: "inbox_message_booking_change_dates_only", ownerable: owner, asociateable: asociated)
	end

	def self.notify_booking_change_fields_and_dates(owner, asociated)
		Message.create(template: "inbox_message_booking_change_fields_and_dates", ownerable: owner, asociateable: asociated)
	end

	def self.notify_booking_left_review(owner, asociated, third)
		Message.create(template: "inbox_message_booking_left_review", ownerable: owner, asociateable: asociated, thirdable: third)
	end

	# Profile
	def self.notify_profile_published(owner)
		Message.create(template: "inbox_message_profile_published", ownerable: owner)
	end

	def self.notify_profile_unpublished(owner)
		Message.create(template: "inbox_message_profile_unpublished", ownerable: owner)
	end

	def self.notify_profile_reject(owner)
		Message.create(template: "inbox_message_profile_reject", ownerable: owner)
	end

	def self.notify_profile_warning(owner)
		Message.create(template: "inbox_message_profile_warning", ownerable: owner)
	end

	# Review
	def self.notify_review_new(owner, asociated, third)
		Message.create(template: "inbox_message_review_new", ownerable: owner, asociateable: asociated, thirdable: third)
	end

	# Coupon
	def self.notify_coupon_sent(owner, asociated)
		Message.create(template: "inbox_message_coupon_sent", ownerable: owner, asociateable: asociated)
	end
end