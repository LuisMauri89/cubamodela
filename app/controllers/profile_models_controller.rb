class ProfileModelsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @profile = ProfileModel.create
    current_user.profileable = @profile
    current_user.save

    redirect_to edit_profile_model_path(@profile)
  end

  def create
    @profile = ProfileModel.new(profile_params)

    if @profile.save
      flash[:success] = "Your profile has been created - !!!Congratulations " + @profile.full_name
      redirect_to '/'
    else
      render 'new'
    end
  end

  def edit
    @profile = ProfileModel.find(params[:id])
    @albums = @profile.albums
  end

  def update
    @profile = ProfileModel.find(params[:id])
    if @profile.update_attributes(profile_params)
      flash[:success] = "Your profile has been updated " + @profile.full_name
      redirect_to '/'
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

    def profile_params
      params.require(:profile_model).permit(:first_name, :last_name, :mobile_phone,
                                            :land_phone, :address, :chest, :waist, 
                                            :hips, :ayes_color_id, :current_province_id, 
                                            :gender, :size_shoes, :size_cloth, :nationality_id,
                                            expertise_ids:[], language_ids:[])
    end
end
