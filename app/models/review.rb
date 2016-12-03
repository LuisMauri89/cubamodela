class Review < ApplicationRecord
	before_save :set_other_locale, if: :new_record?

	def set_other_locale
		if I18n.locale == "en".to_sym
			self.review_es ||= Constant::ES_TRANSLATION_PENDING
		else
			self.review_en ||= Constant::EN_TRANSLATION_PENDING
		end
	end

	# Validations
	validates :review_en, presence: true, if: :locale_en?
	validates :review_es, presence: true, if: :locale_es?

	# Associations
	belongs_to :fromable, polymorphic: true
	belongs_to :toable, polymorphic: true

	# Scopes
	scope :review_needs_translation, -> { where(review_en: Constant::EN_TRANSLATION_PENDING).or(self.where(review_es: Constant::ES_TRANSLATION_PENDING)) }
  	scope :needs_translation, -> { review_needs_translation.order("created_at ASC") }

	def locale_en?
		return I18n.locale == "en".to_sym
	end

	def locale_es?
		return I18n.locale == "es".to_sym
	end

	def review_present
    if self.review_en.present?
      return self.review_en[0..20]
    else
      return self.review_es[0..20]
    end
  end
end
