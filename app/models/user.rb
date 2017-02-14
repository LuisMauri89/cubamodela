class User < ApplicationRecord
  # Validations
  validates :kind, inclusion: { in: %w(contractor model photographer other) }

  # Role
  enum role: [:user, :admin]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
  	self.role ||= :user
  end

  # Kind
  enum kind: [:white, :contractor, :model, :photographer, :other]

  after_initialize :set_default_kind, if: :new_record?

  def set_default_kind
    if self.admin?
      self.other!
    else
      self.kind ||= :white
    end
  end

  before_save :set_profile_meta, if: :new_record?

  def set_profile_meta
    if self.profileable.nil?

      case self.kind
      when "contractor"
        @profile = ProfileContractor.create
        @profile.plan = Plan.get_contractor_free_plan
      when "model"
        @profile = ProfileModel.create
        @profile.albums.create(name: Constant::ALBUM_PROFESSIONAL_NAME)
        @profile.albums.create(name: Constant::ALBUM_POLAROID_NAME)
        @profile.plan = Plan.get_model_free_plan
      when "photographer"
        @profile = ProfilePhotographer.create
        @profile.albums.create(name: Constant::ALBUM_PROFESSIONAL_NAME)
        @profile.plan = Plan.get_photographer_basic_plan
      end
      
      @profile.albums.create(name: Constant::ALBUM_PROFILE_NAME)
      @profile.create_wallet

      @profile.save

      self.profileable = @profile
    end
  end

  # Scopes
  scope :admins, -> { where(role: "admin") }
  scope :users_all, -> { where(role: "user") }

  # Devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  def confirmation_required?
    !self.admin?
  end

  # Profile
  belongs_to :profileable, polymorphic: true, optional: true, dependent: :destroy

  def self.search_by_email(filter)
    role_user.where("email LIKE ?", "%#{filter}%")
  end
end
