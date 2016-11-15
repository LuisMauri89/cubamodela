class ClothSize < ApplicationRecord
	# Validations
	validates :gender, presence: true, inclusion: { in: %w(Female Male) }
	validates :usa, presence: true
	validates :eur, presence: true
	validates :uk, presence: true
	validate :valid_usa_size
	validate :valid_eur_size
	validate :valid_uk_size

	# Custom Validators
	def valid_usa_size
	    size = usa.to_i
	    if size < 4 || size > 16
	    	errors.add(:usa, "not in range.")
	    end
	end

	def valid_eur_size
	    size = eur.to_i
	    if size < 35 || size > 49
	    	errors.add(:eur, "not in range.")
	    end
	end

	def valid_uk_size
	    size = uk.to_i
	    if size < 2 || size > 14
	    	errors.add(:uk, "not in range.")
	    end
	end

	# Get sizes
	def self.get_eur_size(gender, usa_size)
		size = usa_size.to_s

		eur_size = where(gender: gender, usa: size).first

		return eur_size.eur << " EUR"
	end

	def self.get_uk_size(gender, usa_size)
		size = usa_size.to_s

		uk_size = where(gender: gender, usa: size).first

		return uk_size.uk << " UK"
	end
end
