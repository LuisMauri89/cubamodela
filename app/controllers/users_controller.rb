class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.where(role: "user")
  end
end
