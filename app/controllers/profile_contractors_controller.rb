class ProfileContractorsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update]
  before_action :set_profile, only: [:show, :edit, :update, :plans, :destroy]
  before_action :check_if_can, only: [:show, :create, :update, :plans, :destroy]

  def index
  end

  def show
  end

  def new
    if current_user.profileable.nil?
      @profile = ProfileContractor.create
      build_profile_meta

      authorize! :new, @profile

      current_user.profileable = @profile
      current_user.save

      redirect_to edit_profile_contractor_path(@profile)
    else
      redirect_to edit_profile_contractor_path(@profile)
    end
  end

  def create
    redirect_to new_profile_contractor_path
  end

  def edit
    @album_profile_picture = @profile.albums.where(name: Constant::ALBUM_PROFILE_NAME).first

    respond_to do |format|
      format.html
      format.js
    end
  end

  def plans
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
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
      params.require(:profile_contractor).permit(:first_name, :last_name, :mobile_phone,
                                            :land_phone, :address, :represent, 
                                            :nationality_id, language_ids:[])
    end

    def set_profile
      @profile = ProfileContractor.find(params[:id])
    end

    def check_if_can
      authorize! action_name.to_s.to_sym, @profile
    end

    def build_profile_meta
      @profile.albums.create(name: Constant::ALBUM_PROFILE_NAME)

      @profile.create_wallet
    end
end
