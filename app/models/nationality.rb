class Nationality < ApplicationRecord
	# Validations
	validates :name_es, length: { in: 3..20 }
	validates :name_en, length: { in: 3..20 }
	
	# Associations
	has_many :profile_models
end
