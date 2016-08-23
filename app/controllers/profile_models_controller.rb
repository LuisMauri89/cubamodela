class ProfileModelsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @profile = ProfileModel.create
    build_profile_meta
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

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @profile = ProfileModel.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(profile_params)
        format.html { redirect_to '/', success: 'Your profile has been updated ' + @profile.full_name + '.' }
        format.js
      else
        format.html { render action: 'edit' }
        format.js
      end
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

    def build_profile_meta
      @profile.albums.create(name: "Profile Photo")
      @profile.albums.create(name: "Profesional Book")
      @profile.albums.create(name: "Polaroid")
    end
end
