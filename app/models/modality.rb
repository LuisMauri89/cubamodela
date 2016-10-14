class Modality < ApplicationRecord
	# Associations
	has_and_belongs_to_many :profile_models, dependent: :destroy
	has_and_belongs_to_many :castings, dependent: :destroy
end
