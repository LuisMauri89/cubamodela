class Review < ApplicationRecord
	after_initialize :set_other_locale, if: :new_record?

	def set_other_locale
		if I18n.locale == "en".to_sym
			self.review_es ||= "traduccion pendiente"
		else
			self.review_en ||= "pending translation"
		end
	end

	# Validations
	validates :review_en, presence: true
	validates :review_es, presence: true

	# Associations
	belongs_to :fromable, polymorphic: true
	belongs_to :toable, polymorphic: true
end
