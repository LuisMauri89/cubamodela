class User < ApplicationRecord

  enum role: [:user, :admin]
  enum kind: [:contractor, :model, :photographer, :makeup_artist]	

  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_kind, :if => :new_record?

  def set_default_role
  	self.role ||= :user
  end

  def set_default_kind
  	self.kind ||= :contractor
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
