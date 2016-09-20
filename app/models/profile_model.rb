class ProfileModel < ApplicationRecord
	# Validations
	validates :first_name, length: { in: 3..20 }, allow_blank: true
	validates :last_name, length: { in: 3..20 }, allow_blank: true
	validates :mobile_phone, length: { in: 8..20 }, allow_blank: true
	validates :land_phone, length: { in: 8..20 }, allow_blank: true
	validates :address, length: { maximum: 100 }, allow_blank: true
	validates :chest, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 200 }, allow_blank: true
	validates :waist, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 200 }, allow_blank: true
	validates :hips, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 200 }, allow_blank: true
	validates :gender, inclusion: { in: %w(Female Male) }, allow_blank: true
	validates :size_shoes, numericality: { only_integer: true, greater_than_or_equal_to: 20, less_than_or_equal_to: 50 }, allow_blank: true
	validates :size_cloth, numericality: { only_integer: true, greater_than_or_equal_to: 20, less_than_or_equal_to: 500 }, allow_blank: true

	# User
	has_one :user, as: :profileable

	# Nomenclators
	belongs_to :ayes_color, class_name: "Color", foreign_key: "ayes_color_id", optional: true
	belongs_to :current_province, class_name: "Province", foreign_key: "current_province_id", optional: true
	has_and_belongs_to_many :expertises, dependent: :destroy
	has_and_belongs_to_many :languages, dependent: :destroy
	belongs_to :nationality, optional: true

	# Pictures
	has_many :albums, as: :profileable, dependent: :destroy
	has_many :photos, through: :albums

	# Studies
	has_many :studies, as: :ownerable, dependent: :destroy

	#Check if profile is completed
	def profile_complete?
		parameters_with_values = self.generate_array_of_param_with_value

		parameters_with_values.each do |p|
			return p if p
		end

		return false
	end

	def profile_complete_progress
		progress = 0
		parameters_with_values = self.generate_array_of_param_with_value

		progress = parameters_with_values.reject{ |p| p }.length

		return progress
	end

	def profile_complete_progress_total
		total = 18
	end

	def profile_complete_progress_percentage
		progress = (self.profile_complete_progress * 100)/self.profile_complete_progress_total
	end

	# Get full name
	def full_name
		if self.first_name and self.last_name
			self.first_name + " " + self.last_name
		else
			"Unknown"
		end
	end

	def get_profile_model_profile_picture_url(size)
		begin
			return self.albums.where(name: "Profile Photo").first.photos.last.image.url(size)
		rescue
			return "missing_profile_picture.jpg"
		end
	end

	def generate_array_of_param_with_value
		parameters_with_values = [self.first_name.empty?, self.last_name.empty?, self.gender.nil?, self.mobile_phone.empty?, self.land_phone.empty?, self.address.empty?, self.current_province.nil?, self.nationality.nil?, self.ayes_color.nil?, self.chest.nil?, self.waist.nil?, self.hips.nil?, self.size_shoes.nil?, self.size_cloth.nil?]
		parameters_with_values << self.add_expertises_to_progress
		parameters_with_values << self.add_languages_to_progress
		parameters_with_values << self.add_profile_picture_album_to_progress
		parameters_with_values << self.add_profesional_book_album_to_progress

		return parameters_with_values
	end

	def add_expertises_to_progress
		begin
			if self.expertises.any?
				return false
			end

			return true
		rescue
			return true
		end
	end

	def add_languages_to_progress
		begin
			if self.languages.any?
				return false
			end

			return true
		rescue
			return true
		end
	end

	def add_profile_picture_album_to_progress
		begin
			profile_picture_album = self.albums.where(name: "Profile Photo").first
			if profile_picture_album.photos.any?
				return false
			end

			return true
		rescue
			return true
		end
	end

	def add_profesional_book_album_to_progress
		begin
			profesional_book_album = self.albums.where(name: "Profesional Book").first
			if profesional_book_album.photos.any?
				return false
			end

			return true
		rescue
			return true
		end
	end
end
