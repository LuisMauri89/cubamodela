class Notification

	# Notify methods
	def self.notify_casting_invitation(owner, asociated)
		Message.create(template: "inbox_message_casting_invitation", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_confirmation(owner, asociated, thirdable)
		Message.create(template: "inbox_message_casting_confirmation", ownerable: owner, asociateable: asociated, thirdable: thirdable)
	end

	def self.notify_casting_application(owner, asociated, thirdable)
		Message.create(template: "inbox_message_casting_application", ownerable: owner, asociateable: asociated, thirdable: thirdable)
	end

	def self.notify_casting_application_confirmation(owner, asociated)
		Message.create(template: "inbox_message_casting_application_confirmation", ownerable: owner, asociateable: asociated)
	end

	def self.notify_new_casting_free(owner, asociated)
		Message.create(template: "inbox_message_new_casting_free", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_dates_changed_invited(owner, asociated)
		Message.create(template: "inbox_message_casting_dates_changed_invited", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_dates_changed_confirmed(owner, asociated)
		Message.create(template: "inbox_message_casting_dates_changed_confirmed", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_dates_changed_applied(owner, asociated)
		Message.create(template: "inbox_message_casting_dates_changed_applied", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_closed(owner, asociated)
		Message.create(template: "inbox_message_casting_closed", ownerable: owner, asociateable: asociated)
	end

	def self.notify_casting_canceled(owner, asociated)
		Message.create(template: "inbox_message_casting_canceled", ownerable: owner, asociateable: asociated)
	end

	def self.notify_profile_published(owner)
		Message.create(template: "inbox_message_profile_published", ownerable: owner)
	end

	def self.notify_profile_unpublished(owner)
		Message.create(template: "inbox_message_profile_unpublished", ownerable: owner)
	end
end