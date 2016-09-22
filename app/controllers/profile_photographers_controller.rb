class ProfilePhotographersController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @photographers = ProfilePhotographer.all
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show_resume
  end

  def new
    if current_user.profileable.nil?
      @profile = ProfilePhotographer.create
      build_profile_meta
      current_user.profileable = @profile
      current_user.save

      redirect_to edit_profile_photographer_path(@profile)
    else
      redirect_to edit_profile_photographer_path(current_user.profileable)
    end
  end

  def create
    redirect_to new_profile_photographer_path
  end

  def edit
    @album_profile_picture = @profile.albums.where(name: "Profile Photo").first

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
      params.require(:profile_photographer).permit(:first_name, :last_name, :mobile_phone,
                                            :land_phone, :address, :gender, :nationality_id)
    end

    def set_profile
      @profile = ProfilePhotographer.find(params[:id])
    end

    def build_profile_meta
      @profile.albums.create(name: "Profile Photo")
      @profile.albums.create(name: "Profesional Book")
    end
end
