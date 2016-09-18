class PhotosController < ApplicationController

  def show
  	set_photo_belongs_to
  	@photo = Photo.find(params[:id])

  	respond_to do |format|
  		format.js
  	end
  end	

  def new
  	set_photo_type
  	set_photo_belongs_to

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
  	set_photo_type
  	set_photo_belongs_to
  	@photo = Photo.find(params[:photo_id])

  	respond_to do |format|
  		format.js
  	end
  end

  def destroy
  	set_photo_belongs_to
  	@photo = Photo.find(params[:id])

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

  	def save_photo_belongs_to
  		if params[:album_id]
  			album = Album.find(params[:album_id])
  			@photo.attachable = album
  		end
  	end

  	def set_photo_belongs_to
  		if params[:album_id]
  			@album = Album.find(params[:album_id])
  		end
  	end

  	def set_photo_type
  		@photo_type = params[:type].to_s || params[:photo][:func].to_s
  		case @photo_type
  		when "profile"
  			@maxFiles = 1
  		when "album"
  			@maxFiles = 1000	
  		end
  	end
end
