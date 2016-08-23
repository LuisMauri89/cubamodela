class Color < ApplicationRecord
	# Validations
	validates :name, length: { in: 3..20 }

	# Associations
	has_many :profile_models, foreign_key: "ayes_color_id"
end
