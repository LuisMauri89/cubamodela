class Color < ApplicationRecord
	# Associations
	has_many :profile_models, foreign_key: "ayes_color_id"
end
