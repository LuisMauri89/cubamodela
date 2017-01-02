class ProfileModel < ApplicationRecord

	# Level
	enum level: [:new_face, :professional_model]

	after_initialize :set_default_level, if: :new_record?

	def set_default_level
		self.level ||= :new_face
	end

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
	scope :base, -> { joins(:plan).order('plans.priority ASC') }
	scope :base_ready, -> { base.where(reviewed: true) }
	scope :ready, -> { base_ready.order("created_at ASC") }
	scope :not_ready, -> { where(reviewed: false).order("created_at ASC") }
	scope :invitable, -> (casting) { ready.reject{ |pm| !pm.can_apply?(casting) } }
	scope :new_faces, -> { base_ready.where(level: "new_face").order("created_at ASC") }
	scope :professional_models, -> { base_ready.where(level: "professional_model").order("created_at ASC") }
	scope :premium_models, -> { ready.select{ |pm| pm.premium? } }

	# User
	has_one :user, as: :profileable

	# Castings
	has_many :intents
	has_many :castings, through: :intents
	has_many :valid_castings, -> { where(status: ["active", "closed"]).where("casting_date > :today", today: Date.today).order("created_at DESC") }, through: :intents, source: :casting
	has_many :bookings, dependent: :destroy
	has_many :valid_bookings, -> { where(status: ["booked", "confirmed"]).where("casting_date >= :today", today: DateTime.now).order("created_at DESC") }, dependent: :destroy, class_name: "Booking"
	has_many :index_bookings, -> { where("casting_date >= :today", today: DateTime.now).order("created_at DESC") }, dependent: :destroy, class_name: "Booking"
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

	# Votes
	has_many :votes, as: :ownerable, dependent: :destroy

	# Request
	has_one :level_request, as: :requester, dependent: :destroy

	# Wallet
	has_one :wallet, as: :ownerable
	has_many :coupon_charges, through: :wallet

	# Plan
	belongs_to :plan

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
			return I18n.t('activerecord.attributes.profile_model.birth_date_not_present')
		end
	end

	def get_integer_age
		if birth_date.present?
			return ((Date.today - birth_date) / 365).to_i
		else
			return 0
		end
	end

	def get_profile_picture_url(size)
		begin
			return albums.where(name: Constant::ALBUM_PROFILE_NAME).first.photos.last.image.url(size)
		rescue
			return "missing_profile_picture.jpg"
		end
	end

	def get_profesional_book_album_photos
		begin
			return albums.where(name: Constant::ALBUM_PROFESSIONAL_NAME).first.photos.limit(self.plan.album_professional_max)
		rescue
			return []
		end
	end

	def get_profesional_book_album_photos_count
		begin
			return albums.where(name: Constant::ALBUM_PROFESSIONAL_NAME).first.photos.limit(self.plan.album_professional_max).count
		rescue
			return 0
		end
	end

	def get_polaroid_album_photos
		begin
			return albums.where(name: Constant::ALBUM_POLAROID_NAME).first.photos.limit(self.plan.album_polaroid_max)
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

	def request_sent?
		return self.level_request.present?
	end

	def set_profile_warning
		self.warnings_state = true
		self.warnings_count += 1
		self.warnings_last_made = Date.today

		save
	end

	def reset_warnings(on_save)
		self.warnings_state = false
		self.warnings_count = 0
		self.warnings_last_made = nil
		
		if on_save
			save
		end
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
			profile_picture_album = albums.where(name: Constant::ALBUM_PROFILE_NAME).first
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
			profesional_book_album = albums.where(name: Constant::ALBUM_PROFESSIONAL_NAME).first
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
		self.reviewed = true
	end

	def unpublish
		self.reviewed = false
	end

	def get_votes_count
		begin
			return votes.sum(:votes_number).to_i
		rescue
			return 0
		end
	end

	def try_vote!(votant)
		if votes.exists?(votable_id: votant.id, votable_type: votant.class.name)
			vote = votes.where(votable_id: votant.id, votable_type: votant.class.name).first

			if (Date.today - vote.last_vote_date) >= 180 
				vote.update(votes_number: vote.votes_number + 1, last_vote_date: Date.today)
				return vote.save
			else
				return false
			end
		else
			votes.create(votable: votant, votes_number: 1, last_vote_date: Date.today)
			return true
		end
	end

	def can_vote?(votant)
		begin
			vote = votes.where(votable_id: votant.id, votable_type: votant.class.name).first

			if vote != nil
				return (Date.today - vote.last_vote_date) >= 180 
			else
				return true
			end		
		rescue
			return false
		end
	end

	def can_upgrade_level?
		return self.new_face?
	end

	def upgrade_level
		self.professional_model!
	end

	def upgrade_plan(plan)
		case plan
		when "premium"
			self.plan = Plan.get_model_premium_plan
		end

		save
	end

	def can_upload_photo?(photo_type)
		current_amount = 0
		allow = true

		case photo_type
		when "profile"
			return [allow, nil]
		when "professional"
			current_amount = albums.where(name: Constant::ALBUM_PROFESSIONAL_NAME).first.photos.count

			allow = self.plan.can_upload_photo?(photo_type, current_amount)
			return allow ? [allow, nil] : [allow, I18n.t('views.albums.messages.professional_max')]
		when "polaroid"
			current_amount = albums.where(name: Constant::ALBUM_POLAROID_NAME).first.photos.count

			allow = self.plan.can_upload_photo?(photo_type, current_amount)
			return allow ? [allow, nil] : [allow, I18n.t('views.albums.messages.polaroid_max')]
		end
	end

	def premium?
		return self.plan.premium?
	end
end
