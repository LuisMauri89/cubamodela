class ChatMessage < ApplicationRecord

  # Validations
  validates :body, presence: true, length: { in: 3..500 }	

  # Associations
  has_many :children, class_name: "ChatMessage", foreign_key: "parent_id"
  belongs_to :parent, class_name: "ChatMessage"	
  belongs_to :ownerable, polymorphic: true
  belongs_to :fromable, polymorphic: true

  #Scopes
  scope :order_desc, -> { order("created_at DESC") }
  scope :order_asc, -> { order("created_at ASC") }
end
