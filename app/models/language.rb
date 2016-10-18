class Language < ApplicationRecord
	# Validations
	validates :name, length: { in: 3..20 }
	
	# Associations
	has_and_belongs_to_many :profile_models
	has_and_belongs_to_many :profile_photographers
	has_and_belongs_to_many :profile_contractors
end
