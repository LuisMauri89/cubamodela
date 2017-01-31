class Province < ApplicationRecord
	# Validations
	validates :name_en, length: { in: 3..20 }
	validates :name_es, length: { in: 3..20 }
	
	# Associations
	has_many :profile_models, foreign_key: "current_province_id"

	def name
		case I18n.locale
		when "en".to_sym
			return self.name_en
		when "es".to_sym
			return self.name_es
		end
	end
end
