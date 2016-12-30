class CastingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_casting, only: [:show, 
                                     :show_photo, 
                                     :translate, 
                                     :manage, 
                                     :edit, :edit_photos, 
                                     :index_invite, 
                                     :index_invited, 
                                     :index_confirmed, 
                                     :index_applied, 
                                     :apply, 
                                     :invite, 
                                     :confirm, 
                                     :update, 
                                     :close, 
                                     :activate, 
                                     :cancel, 
                                     :destroy]
  before_action :set_profile, only: [:invite, :confirm, :apply, :index_custom_invite]
  before_action :set_contractor, only: [:index_custom, :index_custom_invite, :casting_reviews]
  before_action :set_list_item, only: [:index_invite, 
                                       :index_invited, 
                                       :index_confirmed, 
                                       :index_favorites, 
                                       :index_applied, 
                                       :invite]
  before_action :check_if_can, only: [:manage, 
                                      :edit, 
                                      :edit_photos, 
                                      :casting_reviews, 
                                      :index_invite, 
                                      :index_invited, 
                                      :index_confirmed, 
                                      :index_applied, 
                                      :index_custom, 
                                      :index_custom_invite, 
                                      :invite, 
                                      :confirm, 
                                      :apply, 
                                      :update, 
                                      :close, 
                                      :cancel, 
                                      :activate, 
                                      :destroy]
  before_action :set_pagination_data, only: [:index]
  before_action :set_pagination_data_invite, only: [:manage, :index_invite]

  def index
  	@castings = Casting.valid_castings.offset(@index * @limit).limit(@limit)

  	respond_to do |format|
  		format.html
  		format.js
  	end
  end

  def index_custom
    @castings = @contractor.valid_castings
  end

  def index_custom_invite
    @castings = @contractor.valid_castings
  end

  def index_invite
    @models = ProfileModel.ready.offset(@index * @limit).limit(@limit).reject{ |profile| !profile.can_apply?(@casting) }

    respond_to do |format|
      format.js
    end
  end

  def index_invited
    @intents = @casting.intents.models_invited

    respond_to do |format|
      format.js
    end
  end

  def index_confirmed
    @intents = @casting.intents.models_confirmed

    respond_to do |format|
      format.js
    end
  end

  def index_favorites
  end

  def index_applied
    @intents = @casting.intents.models_applied

    respond_to do |format|
      format.js
    end
  end

  def casting_reviews
    respond_to do |format|
      format.js
    end
  end

  def index_left_reviews
    @casting_review = CastingReview.find(params[:casting_review_id])

    authorize! :index_left_reviews, @casting_review.casting

    @models = @casting_review.casting.confirmed_intents.map{ |i| i.profile_model }
  end

  def dont_show_again_casting_reviews
    @casting_review = CastingReview.find(params[:casting_review_id])

    authorize! :dont_show_again_casting_reviews, @casting_review.casting

    @casting_review.show_again = false

    respond_to do |format|
      if @casting_review.save
        format.html{ redirect_to custom_index_castings_path(contractor_id: @casting_review.profile_contractor_id) }
        format.js
      else
        @models = @casting_review.casting.confirmed_intents.map{ |i| i.profile_model }
        format.html{ render :index_left_reviews, error: t('views.castings.messages.dont_show_again_failed') }
        format.js
      end
    end
  end

  def show
    generate_needed_info
    respond_to do |format|
      format.html
    end
  end

  def show_photo
    @photo = Photo.find(params[:photo_id])

    respond_to do |format|
      format.js
    end
  end

  def translate
    respond_to do |format|
      format.html
    end
  end

  def new
  	@casting = Casting.new
  	authorize! :new, @casting
  end

  def create
  	@casting = Casting.new(casting_params)
  	@casting.ownerable = current_user.profileable

  	authorize! :create, @casting

  	respond_to do |format|
  		if @casting.valid?

        @charge_success, @message = Bank.charge(current_user.profileable, Constant::CASTING_CREATION_COST.to_f, "casting_creation", false)
        if @charge_success
          @casting.save
          CastingReview.create(casting: @casting, profile_contractor: @casting.ownerable, show_again: true)
          CastingNewFreeJob.perform_later(@casting)
          format.html { redirect_to edit_photos_casting_path(@casting), notice: t('views.castings.messages.create') }
        else
          format.html { render :new }
        end
  		else
  			format.html { render :new }
  		end
  	end
  end

  def manage
    @models = ProfileModel.ready.offset(@index * @limit).limit(@limit).reject{ |profile| !profile.can_apply?(@casting) }
  end

  def edit
    message = @casting.allow_edit?

  	if !message.nil?
  		redirect_to castings_path, notice: message
  	end
  end

  def edit_photos
  end

  def update
  	respond_to do |format|
      old_casting = Casting.find(params[:id])
      if @casting.valid?
        
        if @casting.update_requires_charge(old_casting)
          @charge_success, @message = Bank.charge(current_user.profileable, Constant::CASTING_UPDATE_DATES_CHANGE_COST.to_f, "casting_dates_change", false)
          if @charge_success

            @casting.update(casting_params)
            @casting.send_update_notification(old_casting)

            format.html { redirect_to manage_casting_path(@casting), notice: t('views.castings.messages.update') }
          else
            format.html { render :edit }
          end
        else
          @casting.update(casting_params)
          @casting.send_update_notification(old_casting)

          format.html { redirect_to manage_casting_path(@casting), notice: t('views.castings.messages.update') }
        end
      else
        format.html { render :edit }
      end
    end
  end

  def apply
    @intent = @casting.try_apply!(@profile)

    respond_to do |format|
      if @intent.save
        CastingApplicationJob.perform_later(@casting.ownerable, @casting, @profile)
        format.js
      else
        format.js
      end
    end
  end

  def invite
    case @list_item
    when "applied"
      @intent = @casting.try_confirm!(@profile)
    else
      @intent = @casting.try_invite!(@profile) 
    end

    respond_to do |format|
      if @intent.save

        case @list_item
        when "applied"
          CastingApplicationConfirmedJob.perform_later(@profile, @casting)
        else
          CastingInvitationJob.perform_later(@profile, @casting) 
        end

        format.html { redirect_to profile_models_path, notice: I18n.t('views.castings.messages.associations.invited') }
        format.js
      else
        format.html { redirect_to request.referrer, notice: @intent.get_first_base_error }
        format.js
      end
    end
  end

  def confirm
    @intent = @casting.try_confirm!(@profile)
    @from = params[:from]

    respond_to do |format|
      if @intent.save
        CastingInvitationConfirmedJob.perform_later(@casting.ownerable, @casting, @profile)
        format.js
      else
        format.js
      end
    end
  end

  def close
  	@casting.try_close!

    respond_to do |format|
    	if @casting.save
          CastingClosedJob.perform_later(@casting)
      		format.js
      	else
      		format.js
      	end
    end
  end

  def activate
    @casting.try_activate!

    respond_to do |format|
      if @casting.save
          format.js
        else
          format.js
        end
    end
  end

  def cancel
  	@casting.try_cancel!

    respond_to do |format|
      	if @casting.save
          CastingCanceledJob.perform_later(@casting)
  	  		format.js
  	  	else
  	  		format.js
  	  	end
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_casting
      @casting = Casting.find(params[:id])
    end

    def set_profile
      @profile = ProfileModel.find(params[:profile_id])
    end

    def set_contractor
      @contractor = ProfileContractor.find(params[:contractor_id])
    end

    def set_list_item
      @list_item = params[:list_item].to_s || "none"
    end

    def check_if_can
      @casting ||= Casting.new
      authorize! action_name.to_s.to_sym, @casting
    end

    def set_pagination_data
    	@limit = 20
    	@index = params[:next_page].nil? ? 0 : params[:next_page].to_i
    	@next_page = @index + 1
    	count = Casting.valid_castings.count
    	@totalf = count / @limit
    	@total = (count % @limit) > 0 ? @totalf.to_i + 1 : @totalf

    	if @next_page >= @total
    		@next_page = 0
    	end
    end

    def set_pagination_data_invite
      @limit = 20
      @index = params[:next_page].nil? ? 0 : params[:next_page].to_i
      @next_page = @index + 1
      count = ProfileModel.invitable(@casting).count
      @totalf = count / @limit
      @total = (count % @limit) > 0 ? @totalf.to_i + 1 : @totalf

      if @next_page >= @total
        @next_page = 0
      end
    end

    def generate_needed_info
      @modality_cols_batch = @casting.modalities.any? ? (@casting.modalities.count.to_f / 2).ceil : 0
      @category_cols_batch = @casting.categories.any? ? (@casting.categories.count.to_f / 2).ceil : 0
    end

    def generate_casting_reviews_url
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def casting_params
      params.require(:casting).permit(:title_en, :title_es, :description_en, :description_es, :location_en, :location_es, :expiration_date, :casting_date, :shooting_date, :is_direct, :access_type, modality_ids:[], category_ids:[])
    end
end
