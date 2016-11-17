class Review < ApplicationRecord
	before_save :set_other_locale, if: :new_record?

	def set_other_locale
		if I18n.locale == "en".to_sym
			self.review_es ||= "traduccion pendiente"
		else
			self.review_en ||= "pending translation"
		end
	end

	# Validations
	validates :review_en, presence: true, if: :locale_en?
	validates :review_es, presence: true, if: :locale_es?

	# Associations
	belongs_to :fromable, polymorphic: true
	belongs_to :toable, polymorphic: true

	def locale_en?
		return I18n.locale == "en".to_sym
	end

	def locale_es?
		return I18n.locale == "es".to_sym
	end
end
