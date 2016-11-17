class ProfileContractor < ApplicationRecord
	# Validations
	validates :first_name, length: { in: 3..20 }, allow_blank: true
	validates :last_name, length: { in: 3..20 }, allow_blank: true
	validates :represent, length: { in: 3..100 }, allow_blank: true
	validates :mobile_phone, length: { in: 8..20 }, allow_blank: true
	validates :land_phone, length: { in: 8..20 }, allow_blank: true
	validates :address, length: { maximum: 100 }, allow_blank: true

	# User
	has_one :user, as: :profileable

	# Castings
	has_many :castings, -> { order "created_at DESC" }, as: :ownerable, dependent: :destroy
	has_many :valid_castings, -> { where(status: ["active", "closed"]).where("casting_date >= :today", today: DateTime.now).order("created_at DESC") }, as: :ownerable, dependent: :destroy, class_name: "Casting"
	has_many :bookings, dependent: :destroy
  	has_many :profile_models, through: :bookings

	# Nomenclators
	has_and_belongs_to_many :languages, dependent: :destroy
	belongs_to :nationality, optional: true

	# Pictures
	has_many :albums, as: :profileable, dependent: :destroy
	has_many :photos, through: :albums

	# Inbox
	has_many :messages, -> { order "created_at DESC" }, as: :ownerable, dependent: :destroy

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
		total = 9
	end

	def profile_complete_progress_percentage
		progress = (self.profile_complete_progress * 100)/self.profile_complete_progress_total
	end

	# Get attrs
	
	def get_first_name
		if first_name.present?
			return first_name
		else
			return user.email.split("@")[0]
		end
	end

	def full_name
		if self.first_name.present? and self.last_name.present?
			self.first_name + " " + self.last_name
		else
			"Missing Name"
		end
	end

	def get_profile_picture_url(size)
		begin
			return self.albums.where(name: "Profile Photo").first.photos.last.image.url(size)
		rescue
			return "missing_profile_picture.jpg"
		end
	end

	def get_languages_formated
		lang_formated = ""
		self.languages.each_with_index do |language, index|
			if index == 0
				lang_formated += language.name
			else
				lang_formated += " / "
				lang_formated += language.name
			end
		end

		return lang_formated
	end

	def generate_array_of_param_with_value #.present?
		parameters_with_values = [self.first_name.nil? ? true : self.first_name.empty?, self.last_name.nil? ? true : self.last_name.empty?, self.mobile_phone.nil? ? true : self.mobile_phone.empty?, self.land_phone.nil? ? true : self.land_phone.empty?, self.address.nil? ? true : self.address.empty?, self.represent.nil? ? true : self.represent.empty?, self.nationality.nil?]
		parameters_with_values << self.add_languages_to_progress
		parameters_with_values << self.add_profile_picture_album_to_progress

		return parameters_with_values
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
end
