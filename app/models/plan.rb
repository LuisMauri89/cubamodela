class Plan < ApplicationRecord
  	# Target
  	enum target: [:model, :photographer, :contractor]

  	# Level
  	enum level: [:free, :premium]

  	# Associations
  	has_many :profile_models
  	has_many :profile_photographers
  	has_many :profile_contractors

	def can_upload_photo?(photo_type, current_amount)
		case self.target
		when "model"
			case photo_type
			when "professional"
				return current_amount < self.album_professional_max
			when "polaroid"
				return current_amount < self.album_polaroid_max
			end
		when "photographer"
			return true
		when "contractor"
			case photo_type
			when "casting"
				return current_amount < self.casting_photos_references_max
			end
		end	
	end

	def how_many_can_upload(photo_type, current_amount)
		max = 0
		case self.target
		when "model"
			case photo_type
			when "professional"
				rest = self.album_professional_max - current_amount
				max = rest > 0 ? rest : 0
				return max 
			when "polaroid"
				rest = self.album_polaroid_max - current_amount
				max = rest > 0 ? rest : 0
				return max 
			end
		when "photographer"
			return 100
		when "contractor"
			return 100
		end
	end

	def self.get_model_free_plan
		return where(target: "model", level: "free").first
	end

	def self.get_model_premium_plan
		return where(target: "model", level: "premium").first
	end

	def self.get_contractor_free_plan
		return where(target: "contractor", level: "free").first
	end
end
