class StudiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study, only: [:show, :edit, :update, :destroy]

  # GET /studies
  # GET /studies.json
  def index
    begin
      @studies = current_user.profileable.studies
    rescue
      @studies = []
    end

    respond_to do |format|
      format.js
    end
  end

  # GET /studies/1
  # GET /studies/1.json
  def show
  end

  # GET /studies/new
  def new
    @study = Study.new

    respond_to do |format|
      format.js
    end
  end

  # GET /studies/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /studies
  # POST /studies.json
  def create
    @study = Study.new(study_params)
    @study.ownerable = current_user.profileable

    respond_to do |format|
      if @study.save
        format.js
      else
        format.js
      end
    end
  end

  # PATCH/PUT /studies/1
  # PATCH/PUT /studies/1.json
  def update
    respond_to do |format|
      if @study.update(study_params)
        format.js
      else
        format.js
      end
    end
  end

  # DELETE /studies/1
  # DELETE /studies/1.json
  def destroy
    respond_to do |format|
      if @study.destroy
        format.js
      else
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study
      @study = Study.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_params
      params.require(:study).permit(:title, :place, :description)
    end
end
