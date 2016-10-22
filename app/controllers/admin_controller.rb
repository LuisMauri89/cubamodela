class AdminController < ApplicationController
	before_action :authenticate_user!

	def control_panel
	end

	def model_pending_review
		@models = ProfileModel.not_ready
	end
end