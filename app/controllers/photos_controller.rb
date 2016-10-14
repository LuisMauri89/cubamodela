class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :uploaded, :destroy]
  before_action :set_photo, only: [:show, :uploaded, :destroy]
  before_action :set_photo_belongs_to, only: [:show, :new, :uploaded, :destroy]
  before_action :set_photo_type, only: [:show, :new, :uploaded, :destroy]

  def show
    @destroy_url = generate_destroy_url

  	respond_to do |format|
  		format.js
  	end
  end	

  def new
    @form_url = generate_form_url
    @uploaded_url = generate_uploaded_url

  	respond_to do |format|
  		format.js
  	end
  end

  def create
  	@photo = Photo.new(photo_params)
  	save_photo_belongs_to

  	respond_to do |format|
  		if @photo.save
  			format.json { render json: { message: "success", photo_id: @photo.id, photo_type: @photo.func }, status: 200 }
  		else
	    	format.json { render json: { error: @photo.errors.full_messages.join(',') }, status: 400 }
  		end
  	end
  end

  def uploaded
  	respond_to do |format|
  		format.js
  	end
  end

  def destroy
  	respond_to do |format|
  		if @photo.destroy
  			format.js
  		else
  			format.js
  		end
  	end
  end

  private

    def photo_params
      params.require(:photo).permit(:image, :description, :func, :type)
  	end

  	def set_photo
  		@photo = Photo.find(params[:id])
  	end

  	def set_photo_belongs_to
  		if params[:album_id]
  			@album = Album.find(params[:album_id])
      elsif params[:casting_id]
        @casting = Casting.find(params[:casting_id])
  		end
  	end

  	def set_photo_type
  		@photo_type = params[:type].to_s || params[:photo][:func].to_s
  		case @photo_type
  		when "profile"
  			@maxFiles = 1
  		when "album"
  			@maxFiles = 1000	
      when "casting"
        @maxFiles = 5
  		end
  	end

  	def save_photo_belongs_to
  		if params[:album_id]
  			album = Album.find(params[:album_id])
  			@photo.attachable = album
      elsif params[:casting_id]
        casting = Casting.find(params[:casting_id])
        @photo.attachable = casting
  		end
  	end

    def generate_form_url
      form_url = ""

      case @photo_type
      when "profile"
        form_url = album_photos_path(@album)
      when "album"
        form_url = album_photos_path(@album)
      when "casting"
        form_url = casting_photos_path(@casting)
      end

      return form_url
    end

    def generate_destroy_url
      destroy_url = ""

      case @photo_type
      when "profile"
        destroy_url = album_photo_path(@album, @photo, type: @photo_type)
      when "album"
        destroy_url = album_photo_path(@album, @photo, type: @photo_type)
      when "casting"
        destroy_url = casting_photo_path(@casting, @photo, type: @photo_type)
      end

      return destroy_url
    end

    def generate_uploaded_url
      uploaded_url = ""

      case @photo_type
      when "profile"
        uploaded_url = "/albums/" << @album.id.to_s << "/photos/"
      when "album"
        uploaded_url = "/albums/" << @album.id.to_s << "/photos/"
      when "casting"
        uploaded_url = "/castings/" << @casting.id.to_s << "/photos/"
      end

      return uploaded_url
    end
end
