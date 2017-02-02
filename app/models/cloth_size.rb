class ClothSize < ApplicationRecord
	# Validations
	validates :gender, presence: true
	validates :usa, presence: true
	validates :eur, presence: true
	validates :uk, presence: true
	validate :valid_usa_size
	validate :valid_eur_size
	validate :valid_uk_size

	# Custom Validators
	def valid_usa_size
	    size = usa.to_i
	    if size < 0 || size > 46
	    	errors.add(:usa, "not in range.")
	    end
	end

	def valid_eur_size
	    size = eur.to_i
	    if size < 30 || size > 56
	    	errors.add(:eur, "not in range.")
	    end
	end

	def valid_uk_size
	    size = uk.to_i
	    if size < 2 || size > 46
	    	errors.add(:uk, "not in range.")
	    end
	end

	# Get sizes
	def self.get_eur_size(gender, usa_size)
		size = usa_size.to_s

		eur_size = where(gender: gender, usa: size).first

		if eur_size != nil
			return eur_size.eur << " EUR"
		else
			return "Incorrect size"
		end
	end

	def self.get_uk_size(gender, usa_size)
		size = usa_size.to_s

		uk_size = where(gender: gender, usa: size).first

		if uk_size != nil
			return uk_size.uk << " UK"
		else
			return "Incorrect size"
		end
	end
end
