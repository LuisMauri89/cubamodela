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

  # Scopes
  scope :admins, -> { where(role: "admin") }
  scope :users_all, -> { where(role: "user") }

  # Devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # Profile
  belongs_to :profileable, polymorphic: true, optional: true, dependent: :destroy

  def self.search_by_email(filter)
    role_user.where("email LIKE ?", "%#{filter}%")
  end
end
