class Vote < ApplicationRecord
  # Validations
  validates :ownerable_id, uniqueness: { scope: [:ownerable_type, :votable_id, :votable_type],
    message: :vote_exist }
  validates :votes_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Associations
  belongs_to :ownerable, polymorphic: true
  belongs_to :votable, polymorphic: true
end
