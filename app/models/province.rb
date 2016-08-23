class Province < ApplicationRecord
	# Validations
	validates :name, length: { in: 3..20 }
	
	# Associations
	has_many :profile_models, foreign_key: "current_province_id"
end
