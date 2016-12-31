# Preview all emails at http://localhost:3000/rails/mailers/casting_mailer
class CastingMailerPreview < ActionMailer::Preview
	def email_casting_invitation
		CastingMailer.email_casting_invitation(ProfileModel.first, Casting.first)
	end

	def email_casting_confirmation
		CastingMailer.email_casting_confirmation(ProfileContractor.first, Casting.first, ProfileModel.first)
	end

	def email_casting_application
		CastingMailer.email_casting_application(ProfileContractor.first, Casting.first, ProfileModel.first)
	end

	def email_casting_application_confirmation
		CastingMailer.email_casting_application_confirmation(ProfileModel.first, Casting.first)
	end

	def email_casting_new_free
		CastingMailer.email_casting_new_free(ProfileModel.find(45), Casting.last)
	end
	
	def email_casting_dates_changed_invited
		CastingMailer.email_casting_dates_changed_invited(ProfileModel.first, Casting.first)
	end
	
	def email_casting_dates_changed_confirmed
		CastingMailer.email_casting_dates_changed_confirmed(ProfileModel.first, Casting.first)
	end
	
	def email_casting_dates_changed_applied
		CastingMailer.email_casting_dates_changed_applied(ProfileModel.first, Casting.first)
	end
	
	def email_casting_closed
		CastingMailer.email_casting_closed(ProfileModel.first, Casting.first)
	end
	
	def email_casting_canceled
		CastingMailer.email_casting_canceled(ProfileModel.first, Casting.first)
	end
	
	def email_profile_published
		CastingMailer.email_profile_published(ProfileModel.first)
	end
	
	def email_profile_unpublished
		CastingMailer.email_profile_unpublished(ProfileModel.first)
	end
	
	def email_casting_available_expiration_proximity
		CastingMailer.email_casting_available_expiration_proximity(ProfileModel.first, Casting.first)
	end
	
	def email_casting_invited_expiration_proximity
		CastingMailer.email_casting_invited_expiration_proximity(ProfileModel.first, Casting.first)
	end
	
	def email_casting_invited_date_proximity
		CastingMailer.email_casting_invited_date_proximity(ProfileModel.first, Casting.first)
	end
end