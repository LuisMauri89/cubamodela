class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_can

  def index
  	@users = User.role_user.order("created_at DESC")
  end

  private
  	def check_if_can
      @user ||= User.new
      authorize! action_name.to_s.to_sym, @user
    end
end
