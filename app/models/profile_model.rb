class ProfileModel < ApplicationRecord
	# Validations
	validates :first_name, length: { in: 3..20 }, allow_blank: true
	validates :last_name, length: { in: 3..20 }, allow_blank: true
	validates :mobile_phone, length: { in: 8..20 }, allow_blank: true
	validates :land_phone, length: { in: 8..20 }, allow_blank: true
	validates :address, length: { maximum: 100 }, allow_blank: true
	validates :height, numericality: { greater_than_or_equal_to: 120, less_than_or_equal_to: 210 }, allow_blank: true
	validates :chest, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 200 }, allow_blank: true
	validates :waist, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 200 }, allow_blank: true
	validates :hips, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 200 }, allow_blank: true
	validates :gender, inclusion: { in: %w(Female Male) }, allow_blank: true
	validates :size_shoes, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 16 }, allow_blank: true
	validates :size_cloth, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 16 }, allow_blank: true

	#Scopes
	scope :ready, -> { where(reviewed: true).order("created_at ASC") }
	scope :not_ready, -> { where(reviewed: false).order("created_at ASC") }
	scope :invitable, -> (casting) { ready.reject{ |pm| !pm.can_apply?(casting) } }

	# User
	has_one :user, as: :profileable

	# Castings
	has_many :intents
	has_many :castings, through: :intents
	has_many :valid_castings, -> { where(status: ["active", "closed"]).where("casting_date > :today", today: Date.today).order("created_at DESC") }, through: :intents, source: :casting
	has_many :bookings, dependent: :destroy
  	has_many :profile_contractors, through: :bookings

	# Nomenclators
	belongs_to :eyes_color, class_name: "Color", foreign_key: "eyes_color_id", optional: true
	belongs_to :current_province, class_name: "Province", foreign_key: "current_province_id", optional: true
	has_and_belongs_to_many :expertises, dependent: :destroy
	has_and_belongs_to_many :languages, dependent: :destroy
	has_and_belongs_to_many :modalities, dependent: :destroy
	has_and_belongs_to_many :categories, dependent: :destroy
	belongs_to :nationality, optional: true
	belongs_to :ethnicity, optional: true

	# Pictures
	has_many :albums, as: :profileable, dependent: :destroy
	has_many :photos, through: :albums

	# Studies
	has_many :studies, as: :ownerable, dependent: :destroy

	# Inbox
	has_many :messages, -> { order "created_at DESC" }, as: :ownerable, dependent: :destroy

	# Reviews
	has_many :reviews, as: :toable, dependent: :destroy

	# Profile completeness
	def profile_complete?
		parameters_with_values = generate_array_of_param_with_value

		parameters_with_values.each do |p|
			return false if !p
		end

		return true
	end

	def profile_complete_progress
		progress = 0
		parameters_with_values = generate_array_of_param_with_value

		progress = parameters_with_values.reject{ |p| !p }.length

		return progress
	end

	def profile_complete_progress_total
		total = 21
	end

	def profile_complete_progress_percentage
		progress = (profile_complete_progress * 100)/profile_complete_progress_total
	end

	# Get attrs
	def full_name
		if first_name.present? and last_name.present?
			return first_name << " " << last_name
		else
			return user.email.split("@")[0]
		end
	end

	def get_first_name
		if first_name.present?
			return first_name
		else
			return user.email.split("@")[0]
		end
	end

	def get_age
		if birth_date.present?
			return ((Date.today - birth_date) / 365).to_i
		else
			return "Not setted"
		end
	end

	def get_profile_picture_url(size)
		begin
			return albums.where(name: "Profile Photo").first.photos.last.image.url(size)
		rescue
			return "missing_profile_picture.jpg"
		end
	end

	def get_profesional_book_album_photos
		begin
			return albums.where(name: "Profesional Book").first.photos
		rescue
			return []
		end
	end

	def get_profesional_book_album_photos_count
		begin
			return albums.where(name: "Profesional Book").first.photos.count
		rescue
			return 0
		end
	end

	def get_polaroid_album_photos
		begin
			return albums.where(name: "Polaroid").first.photos
		rescue
			return []
		end
	end

	def get_languages_formated
		lang_formated = ""
		languages.each_with_index do |language, index|
			if index == 0
				lang_formated += language.name
			else
				lang_formated += " / "
				lang_formated += language.name
			end
		end

		return lang_formated
	end

	def get_expertises_formated
		exp_formated = ""
		expertises.each_with_index do |expertise, index|
			if index == 0
				exp_formated += expertise.name
			else
				exp_formated += " / "
				exp_formated += expertise.name
			end
		end

		return exp_formated
	end

	def get_modalities_formated
		mod_formated = ""
		modalities.each_with_index do |modality, index|
			if index == 0
				mod_formated += modality.name
			else
				mod_formated += " / "
				mod_formated += modality.name
			end
		end

		return mod_formated
	end

	# Profile completeness - Helper methods
	def generate_array_of_param_with_value
		parameters_with_values = [first_name.present?, 
								  last_name.present?, 
								  gender.present?, 
								  mobile_phone.present?, 
								  land_phone.present?, 
								  address.present?, 
								  current_province.present?, 
								  nationality.present?, 
								  ethnicity.present?,
								  eyes_color.present?, 
								  height.present?,
								  chest.present?, 
								  waist.present?, 
								  hips.present?, 
								  size_shoes.present?, 
								  size_cloth.present?]

		parameters_with_values << add_expertises_to_progress
		parameters_with_values << add_languages_to_progress
		parameters_with_values << add_modalities_to_progress
		parameters_with_values << add_profile_picture_album_to_progress
		parameters_with_values << add_profesional_book_album_to_progress

		return parameters_with_values
	end

	def add_expertises_to_progress
		begin
			if expertises.any?
				return true
			end

			return false
		rescue
			return false
		end
	end

	def add_languages_to_progress
		begin
			if languages.any?
				return true
			end

			return false
		rescue
			return false
		end
	end

	def add_modalities_to_progress
		begin
			if modalities.any?
				return true
			end

			return false
		rescue
			return false
		end
	end

	def add_profile_picture_album_to_progress
		begin
			profile_picture_album = albums.where(name: "Profile Photo").first
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
			profesional_book_album = albums.where(name: "Profesional Book").first
			if profesional_book_album.photos.any?
				return false
			end

			return true
		rescue
			return true
		end
	end

	# Profile methods
	def can_apply?(casting)
		begin
			return !casting_ids.include?(casting.id)
		rescue
			return true
		end
	end

	def publish
		reviewed = true
	end

	def unpublish
		reviewed = false
	end
end
