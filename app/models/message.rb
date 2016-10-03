class Message < ApplicationRecord
  # Validations
	validates :title, presence: true, length: { in: 3..30 }
	validates :body, presence: true, length: { in: 10..500 }

  # Associations
  belongs_to :ownerable, polymorphic: true
  belongs_to :asociateable, polymorphic: true
end
