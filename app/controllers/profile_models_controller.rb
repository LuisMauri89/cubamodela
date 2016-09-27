class ProfileModelsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update]
  before_action :set_profile, only: [:show, :show_resume, :edit, :update, :destroy]
  #before_action :check_if_can, only: [:new, :create, :edit, :update, :destroy]

  def index
    @models = ProfileModel.all
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def show_resume
    respond_to do |format|
      format.js
    end
  end

  def new
    if current_user.profileable.nil?
      @profile = ProfileModel.create
      build_profile_meta
      current_user.profileable = @profile
      current_user.save

      redirect_to edit_profile_model_path(@profile)
    else
      redirect_to edit_profile_model_path(current_user.profileable)
    end
  end

  def create
    redirect_to new_profile_model_path
  end

  def edit
    @album_profile_picture = @profile.albums.where(name: "Profile Photo").first
    authorize! :edit, @profile

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    respond_to do |format|
      if @profile.update_attributes(profile_params)
        @update_progress = @profile.profile_complete_progress_percentage
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

    def set_profile
      @profile = ProfileModel.find(params[:id])
    end

    def check_if_can
      authorize! action_name, @profile
    end

    def build_profile_meta
      @profile.albums.create(name: "Profile Photo")
      @profile.albums.create(name: "Profesional Book")
      @profile.albums.create(name: "Polaroid")
    end
end
