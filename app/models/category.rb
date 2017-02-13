class Category < ApplicationRecord
	# Validations
	validates :name_en, length: { in: 3..20 }
	validates :name_es, length: { in: 3..20 }
	
	# Associations
	has_and_belongs_to_many :profile_models, dependent: :destroy
	has_and_belongs_to_many :castings, dependent: :destroy
	has_and_belongs_to_many :searches, dependent: :destroy

	# Scopes
	scope :profile_type_model, -> { where(profile_type: "model") }

	def name
		case I18n.locale
		when "en".to_sym
			return self.name_en
		when "es".to_sym
			return self.name_es
		end
	end
end
