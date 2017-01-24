class ProfilePhotographersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update]
  before_action :set_profile, only: [:show, 
                :show_resume, 
                :plans, 
                :albums, 
                :studies, 
                :edit, 
                :update, 
                :destroy]
  before_action :check_if_can, only: [:edit, 
                                      :update, 
                                      :plans, 
                                      :albums, 
                                      :studies, 
                                      :destroy]

  def index
    @photographers = ProfilePhotographer.all
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
      @profile = ProfilePhotographer.create
      build_profile_meta

      authorize! :new, @profile

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
      if @profile.update(profile_params)
        @update_progress = @profile.profile_complete_progress_percentage
        format.html { redirect_to '/', success: 'Your profile has been updated ' + @profile.get_first_name + '.' }
        format.js
      else
        format.html { render action: 'edit' }
        format.js
      end
    end
  end

  def albums
    begin
      @albums = @profile.albums
    rescue
      @albums = []
    end

    respond_to do |format|
      format.js
    end
  end

  def studies
    begin
      @studies = @profile.studies
    rescue
      @studies = []
    end

    respond_to do |format|
      format.js
    end
  end

  def plans
    respond_to do |format|
      format.js
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

    def check_if_can
      authorize! action_name.to_s.to_sym, @profile
    end

    def build_profile_meta
      @profile.albums.create(name: Constant::ALBUM_PROFILE_NAME)
      @profile.albums.create(name: Constant::ALBUM_PROFESSIONAL_NAME)

      @profile.create_wallet

      @profile.plan = Plan.get_photographer_basic_plan

      @profile.save
    end
end
