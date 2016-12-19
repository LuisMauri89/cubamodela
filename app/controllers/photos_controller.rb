class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :uploaded, :destroy]
  before_action :set_photo, only: [:show, :uploaded, :destroy]
  before_action :set_photo_belongs_to, only: [:show, :new, :uploaded, :destroy]
  before_action :set_photo_type, only: [:show, :new, :uploaded, :destroy]
  before_action :check_if_can

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
      allow, message = allow_upload?(@photo.func)
      if allow
    		if @photo.save
    			format.json { render json: { message: "success", photo_id: @photo.id, photo_type: @photo.func }, status: 200 }
    		else
  	    	format.json { render json: { error: @photo.errors.full_messages.join(',') }, status: 400 }
    		end
      else
        format.json { render json: { error: message }, status: 400 }
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
  			@album = Album.find(params[:album_id])
  			@photo.attachable = @album

        @owner = @album.profileable
      elsif params[:casting_id]
        @casting = Casting.find(params[:casting_id])
        @photo.attachable = @casting

        @owner = @casting.ownerable
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

    def check_if_can
      @photo ||= Photo.new
      authorize! action_name.to_s.to_sym, @photo
    end

    def allow_upload?(photo_type)
      case photo_type
      when "profile"
        return @owner.can_upload_photo?(get_photo_type_from_album_name(@album.name))
      when "album"
        return @owner.can_upload_photo?(get_photo_type_from_album_name(@album.name))
      when "casting"
        return @owner.can_upload_photo?("casting", @casting)
      end
    end

    def get_photo_type_from_album_name(album_name)
      case album_name
      when Constant::ALBUM_PROFILE_NAME
        return "profile"
      when Constant::ALBUM_PROFESSIONAL_NAME
        return "professional"
      when Constant::ALBUM_POLAROID_NAME
        return "polaroid"
      end
    end
end
