class Study < ApplicationRecord
	# Validations
	validates :title, length: { in: 5..50 }
	validates :place, length: { in: 3..50 }, allow_blank: true
	validates :description, length: { in: 5..500 }

	# Associations
	belongs_to :ownerable, polymorphic: true
end
