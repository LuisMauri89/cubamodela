class EthnicitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ethnicity, only: [:show, :edit, :update, :destroy]
  before_action :check_if_can, only: [:index, :show, :edit, :update, :delete, :destroy]

  # GET /ethnicities
  # GET /ethnicities.json
  def index
    @ethnicities = Ethnicity.all.order("name_en ASC")
  end

  # GET /ethnicities/1
  # GET /ethnicities/1.json
  def show
  end

  # GET /ethnicities/new
  def new
    @ethnicity = Ethnicity.new

    authorize! :new, @ethnicity
  end

  # GET /ethnicities/1/edit
  def edit
  end

  # POST /ethnicities
  # POST /ethnicities.json
  def create
    @ethnicity = Ethnicity.new(ethnicity_params)

    authorize! :create, @ethnicity

    respond_to do |format|
      if @ethnicity.save
        format.html { redirect_to @ethnicity, notice: 'Ethnicity was successfully created.' }
        format.json { render :show, status: :created, location: @ethnicity }
      else
        format.html { render :new }
        format.json { render json: @ethnicity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ethnicities/1
  # PATCH/PUT /ethnicities/1.json
  def update
    respond_to do |format|
      if @ethnicity.update(ethnicity_params)
        format.html { redirect_to @ethnicity, notice: 'Ethnicity was successfully updated.' }
        format.json { render :show, status: :ok, location: @ethnicity }
      else
        format.html { render :edit }
        format.json { render json: @ethnicity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ethnicities/1
  # DELETE /ethnicities/1.json
  def destroy
    @ethnicity.destroy
    respond_to do |format|
      format.html { redirect_to ethnicities_url, notice: 'Ethnicity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ethnicity
      @ethnicity = Ethnicity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ethnicity_params
      params.require(:ethnicity).permit(:name_en, :name_es)
    end

    def check_if_can
      @ethnicity ||= Ethnicity.new
      authorize! action_name.to_s.to_sym, @ethnicity
    end
end
