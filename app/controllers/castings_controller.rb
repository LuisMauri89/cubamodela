class CastingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_casting, only: [:show, :manage, :edit, :edit_photos, :index_invite, :index_invited, :index_confirmed, :index_applied, :apply, :invite, :confirm, :update, :close, :activate, :cancel, :destroy]
  before_action :set_profile, only: [:invite, :confirm, :apply, :index_custom_invite]
  before_action :set_list_item, only: [:index_invite, :index_invited, :index_confirmed, :index_favorites, :index_applied, :invite]
  before_action :check_if_can, only: [:manage, :edit, :edit_photos, :index_invite, :index_invited, :index_confirmed, :index_applied, :index_custom, :index_custom_invite, :invite, :confirm, :apply, :update, :close, :cancel, :destroy]
  before_action :check_if_can_profile, only: [:confirm, :apply]
  before_action :set_pagination_data, only: [:index]
  before_action :set_pagination_data_invite, only: [:manage, :index_invite]

  def index
  	@castings = Casting.actives.offset(@index * @limit).limit(@limit)

  	respond_to do |format|
  		format.html
  		format.js
  	end
  end

  def index_custom
    @castings = current_user.profileable.castings.order("created_at DESC")
  end

  def index_custom_invite
    @castings = current_user.profileable.castings.where(status: "active").order("created_at DESC")
  end

  def index_invite
    @models = ProfileModel.ready.offset(@index * @limit).limit(@limit)

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

  def show
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
  		if @casting.save
  			format.html { redirect_to edit_photos_casting_path(@casting), notice: 'Casting was successfully created.' }
  		else
  			format.html { render :new }
  		end
  	end
  end

  def manage
    @models = ProfileModel.ready.offset(@index * @limit).limit(@limit)
  end

  def edit
  	if @casting.canceled?
  		redirect_to castings_path, notice: '!!!SORRY a casting canceled can not be edited.'
  	end
  end

  def edit_photos
  end

  def update
  	respond_to do |format|
      if @casting.update(casting_params)
        format.html { redirect_to manage_casting_path(@casting), notice: 'Casting was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def apply
    @intent = @casting.apply_model(@profile)

    respond_to do |format|
      if @intent.save
        format.js
      else
        format.js
      end
    end
  end

  def invite
    if @list_item == "invite"
      @intent = @casting.invite_model(@profile)
    elsif @list_item == "applied"
      @intent = @casting.confirm_model(@profile)
    else
      @intent = @casting.invite_model(@profile)
    end

    respond_to do |format|
      if @intent.save
        Message.create(template: "inbox_message_casting_invitation", ownerable: @profile, asociateable: @casting)
        format.html { redirect_to profile_models_path, notice: 'Invitation successfully.' }
        format.js
      else
        format.html { redirect_to request.referrer, notice: "Invitation failed" }
        format.js
      end
    end
  end

  def confirm
    @intent = @casting.confirm_model(@profile)

    respond_to do |format|
      if @intent.save
        format.js
      else
        format.js
      end
    end
  end

  def close
  	@casting.force_close!

    respond_to do |format|
    	if @casting.save
      		format.js
      	else
      		format.js
      	end
    end
  end

  def activate
    @casting.activate!

    respond_to do |format|
      if @casting.save
          format.js
        else
          format.js
        end
    end
  end

  def cancel
  	@casting.cancel!

    respond_to do |format|
      	if @casting.save
  	  		format.js
  	  	else
  	  		format.js
  	  	end
    end
  end

  def destroy
    respond_to do |format|
    	if @casting.destroy
    		format.html { redirect_to castings_path, notice: 'Casting was successfully destroyed.' }
    		format.js
    	else
    		format.html { redirect_to request.referer, error: '!!!Ups there was a problem.' }
    		format.js
    	end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_casting
      @casting = Casting.find(params[:id])
    end

    def set_profile
      @profile = ProfileModel.find(params[:profile_id])
    end

    def set_list_item
      @list_item = params[:list_item].to_s || "none"
    end

    def check_if_can
      @casting ||= Casting.new
      authorize! action_name.to_s.to_sym, @casting
    end

    def check_if_can_profile
      authorize! action_name.to_s.to_sym, @profile
    end

    def set_pagination_data
    	@limit = 2
    	@index = params[:next_page].nil? ? 0 : params[:next_page].to_i
    	@next_page = @index + 1
    	count = Casting.actives.count
    	@totalf = count / @limit
    	@total = (count % @limit) > 0 ? @totalf.to_i + 1 : @totalf

    	if @next_page >= @total
    		@next_page = 0
    	end
    end

    def set_pagination_data_invite
      @limit = 2
      @index = params[:next_page].nil? ? 0 : params[:next_page].to_i
      @next_page = @index + 1
      count = ProfileModel.ready.count
      @totalf = count / @limit
      @total = (count % @limit) > 0 ? @totalf.to_i + 1 : @totalf

      if @next_page >= @total
        @next_page = 0
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def casting_params
      params.require(:casting).permit(:title, :description, :location, :expiration_date, :casting_date, :shooting_date, :access_type, modality_ids:[])
    end
end
