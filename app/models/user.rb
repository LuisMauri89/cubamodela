class User < ApplicationRecord

  # Role
  enum role: [:user, :admin]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
  	self.role ||= :user
  end

  # Kind
  enum kind: [:contractor, :model, :photographer, :other]

  after_initialize :set_default_kind, if: :new_record?

  def set_default_kind
    if self.admin?
      self.other!
    else
      self.kind ||= :contractor
    end
  end

  # Devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Profile
  belongs_to :profileable, polymorphic: true, optional: true, dependent: :destroy
end
