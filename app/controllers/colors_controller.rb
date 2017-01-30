class ColorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_color, only: [:show, :edit, :update, :destroy]
  before_action :check_if_can, only: [:index, :show, :edit, :update, :delete, :destroy]

  # GET /colors
  # GET /colors.json
  def index
    @colors = Color.all.order("name_en ASC")
  end

  # GET /colors/1
  # GET /colors/1.json
  def show
  end

  # GET /colors/new
  def new
    @color = Color.new

    authorize! :new, @color
  end

  # GET /colors/1/edit
  def edit
  end

  # POST /colors
  # POST /colors.json
  def create
    @color = Color.new(color_params)

    authorize! :create, @color

    respond_to do |format|
      if @color.save
        format.html { redirect_to @color, notice: I18n.t('views.application.messages.create', value: "Color") }
        format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colors/1
  # PATCH/PUT /colors/1.json
  def update
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to @color, notice: 'Color was successfully updated.' }
        format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1
  # DELETE /colors/1.json
  def destroy
    @color.destroy
    respond_to do |format|
      format.html { redirect_to colors_url, notice: 'Color was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_params
      params.require(:color).permit(:name_en, :name_es)
    end

    def check_if_can
      @color ||= Color.new
      authorize! action_name.to_s.to_sym, @color
    end
end
