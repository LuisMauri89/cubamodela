class ProfileModel < ApplicationRecord
	# User
	has_one :user, as: :profileable, dependent: :destroy
end
