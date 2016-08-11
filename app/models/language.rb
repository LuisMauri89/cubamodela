class Language < ApplicationRecord
	# Associations
	has_and_belongs_to_many :profile_models
end
