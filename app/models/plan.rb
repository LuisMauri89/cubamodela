class Plan < ApplicationRecord
  	# Target
  	enum target: [:model, :photographer, :contractor]

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
			return true
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
end
