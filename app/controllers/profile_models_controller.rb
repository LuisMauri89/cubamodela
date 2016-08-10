class ProfileModelsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @profile = ProfileModel.new
  end

  def create
    @profile = ProfileModel.new(profile_params)
    current_user.profileable = @profile

    if @profile.save
      current_user.save
      flash[:success] = "Your profile has been created - !!!Congratulations " + @profile.full_name
      redirect_to '/'
    else
      render 'new'
    end
  end

  def edit
    @profile = ProfileModel.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

    def profile_params
      params.require(:profile_model).permit(:first_name, :last_name, :mobile_phone,
                                   :land_phone, :address, :chest, :waist, :hips)
    end
end
