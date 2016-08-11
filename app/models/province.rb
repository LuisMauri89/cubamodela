class Province < ApplicationRecord
	# Associations
	has_many :profile_models, foreign_key: "current_province_id"
end
