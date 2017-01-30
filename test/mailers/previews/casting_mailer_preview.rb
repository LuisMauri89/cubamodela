# Preview all emails at http://localhost:3000/rails/mailers/casting_mailer
class CastingMailerPreview < ActionMailer::Preview
	def email_casting_invitation
		CastingMailer.email_casting_invitation(ProfileModel.find(45), Casting.first)
	end

	def email_casting_invitation_confirmed
		CastingMailer.email_casting_invitation_confirmed(ProfileContractor.first, Casting.first, ProfileModel.find(45))
	end

	def email_casting_application
		CastingMailer.email_casting_application(ProfileContractor.first, Casting.first, ProfileModel.find(45))
	end

	def email_casting_application_confirmed
		CastingMailer.email_casting_application_confirmed(ProfileModel.find(45), Casting.first)
	end

	def email_casting_new_free
		CastingMailer.email_casting_new_free(ProfileModel.find(45), Casting.last)
	end
	
	def email_casting_change_fields_only
		CastingMailer.email_casting_change_fields_only(ProfileModel.find(45), Casting.first)
	end
	
	def email_casting_change_dates_only
		CastingMailer.email_casting_change_dates_only(ProfileModel.find(45), Casting.first)
	end
	
	def email_casting_change_fields_and_dates
		CastingMailer.email_casting_change_fields_and_dates(ProfileModel.find(45), Casting.first)
	end
	
	def email_casting_expired
		CastingMailer.email_casting_expired(ProfileModel.find(45), Casting.first)
	end
	
	def email_casting_canceled
		CastingMailer.email_casting_canceled(ProfileModel.find(45), Casting.first)
	end
	
	def email_casting_translation
		CastingMailer.email_casting_translation(ProfileModel.find(45), Casting.first)
	end
	
	def email_casting_expiration_proximity
		CastingMailer.email_casting_expiration_proximity(ProfileModel.find(45), Casting.first)
	end
end