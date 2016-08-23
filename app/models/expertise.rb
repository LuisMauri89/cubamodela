class Expertise < ApplicationRecord
	# Validations
	validates :name, length: { in: 3..20 }
	
	# Associations
	has_and_belongs_to_many :profile_models
end
