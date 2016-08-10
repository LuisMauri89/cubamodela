class ProfileModel < ApplicationRecord
	# User
	has_one :user, as: :profileable, dependent: :destroy

	#Check if profile is completed
	def profile_complete?
		not(self.first_name.nil?) && not(self.last_name.nil?)
	end

	def profile_complete_progress
		progress = 0

		if not self.first_name.nil?
			progress += 1
		end

		if not self.last_name.nil?
			progress += 1
		end
	end

	def profile_complete_progress_total
		progress = 2
	end

	def profile_complete_progress_percentage
		progress = 50 #(profile_complete_progress * 100)/profile_complete_progress_total
	end

	# Get full name
	def full_name
		self.first_name + " " + self.last_name
	end
end
