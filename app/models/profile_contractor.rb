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
	has_many :valid_bookings, -> { where(status: ["booked", "confirmed"]).where("casting_date >= :today", today: DateTime.now).order("created_at DESC") }, dependent: :destroy, class_name: "Booking"
  	has_many :profile_models, through: :bookings

	# Nomenclators
	has_and_belongs_to_many :languages, dependent: :destroy
	belongs_to :nationality, optional: true

	# Pictures
	has_many :albums, as: :profileable, dependent: :destroy
	has_many :photos, through: :albums

	# Inbox
	has_many :messages, -> { order "created_at DESC" }, as: :ownerable, dependent: :destroy

	# Wallet
	has_one :wallet, as: :ownerable
	has_many :coupon_charges, through: :wallet

	# Plan
	belongs_to :plan

	# Casting reviews
	has_many :casting_reviews, dependent: :destroy
  	has_many :casting_reviews_show_again, -> { where(show_again: true) }, class_name: "CastingReview"

	#Check if profile is completed
	def profile_complete?
		parameters_with_values = generate_array_of_param_with_value

		parameters_with_values.each do |p|
			return false if !p
		end

		return true
	end

	def profile_complete_progress
		progress = 0
		parameters_with_values = self.generate_array_of_param_with_value

		progress = parameters_with_values.reject{ |p| !p }.length

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

	def generate_array_of_param_with_value
		parameters_with_values = [first_name.present?, 
							      last_name.present?, 
							      mobile_phone.present?, 
							      land_phone.present?, 
							      address.present?, 
							      represent.present?, 
							      nationality.present?]

		parameters_with_values << self.add_languages_to_progress
		parameters_with_values << self.add_profile_picture_album_to_progress

		return parameters_with_values
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

	def can_upload_photo?(photo_type, casting=nil)
		current_amount = 0
		allow = true

		case photo_type
		when "profile"
			return [allow, nil]
		when "casting"
			current_amount = casting.photos.count

			allow = self.plan.can_upload_photo?(photo_type, current_amount)
			return allow ? [allow, nil] : [allow, I18n.t('views.castings.messages.references_photos_max')]
		end
	end
end
