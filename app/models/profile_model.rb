class ProfileModel < ApplicationRecord
	# Validations
	validates :first_name, length: { in: 3..20 }
	validates :last_name, length: { in: 3..20 }

	# User
	has_one :user, as: :profileable, dependent: :destroy

	# Nomenclators
	belongs_to :ayes_color, class_name: "Color", foreign_key: "ayes_color_id", optional: true
	belongs_to :current_province, class_name: "Province", foreign_key: "current_province_id", optional: true
	has_and_belongs_to_many :expertises, dependent: :destroy
	has_and_belongs_to_many :languages, dependent: :destroy
	belongs_to :nationality, optional: true

	# Pictures
	has_many :albums, as: :profileable, dependent: :destroy
	has_many :photos, through: :albums

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
