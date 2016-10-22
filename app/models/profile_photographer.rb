class ProfilePhotographer < ApplicationRecord
  	# Validations
	validates :first_name, length: { in: 3..20 }, allow_blank: true
	validates :last_name, length: { in: 3..20 }, allow_blank: true
	validates :mobile_phone, length: { in: 8..20 }, allow_blank: true
	validates :land_phone, length: { in: 8..20 }, allow_blank: true
	validates :address, length: { maximum: 100 }, allow_blank: true
	validates :gender, inclusion: { in: %w(Female Male) }, allow_blank: true

	# User
	has_one :user, as: :profileable

	# Nomenclators
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
		if self.first_name.present? and self.last_name.present?
			self.first_name + " " + self.last_name
		else
			"Unknown"
		end
	end

	def get_profile_picture_url(size)
		begin
			return self.albums.where(name: "Profile Photo").first.photos.last.image.url(size)
		rescue
			return "missing_profile_picture.jpg"
		end
	end

	def get_profesional_book_album_photos
		begin
			return self.albums.where(name: "Profesional Book").first.photos
		rescue
			return []
		end
	end

	def get_profesional_book_album_photos_count
		begin
			return self.albums.where(name: "Profesional Book").first.photos.count
		rescue
			return 0
		end
	end

	def generate_array_of_param_with_value
		parameters_with_values = [self.first_name.nil? ? true : self.first_name.empty?, self.last_name.nil? ? true : self.last_name.empty?, self.gender.nil?, self.mobile_phone.nil? ? true : self.mobile_phone.empty?, self.land_phone.nil? ? true : self.land_phone.empty?, self.address.nil? ? true : self.address.empty?, self.nationality.nil?]
		parameters_with_values << self.add_profile_picture_album_to_progress
		parameters_with_values << self.add_profesional_book_album_to_progress

		return parameters_with_values
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
