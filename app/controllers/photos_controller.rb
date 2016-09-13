class PhotosController < ApplicationController

  def show

  end	

  def new
  	@album = Album.find(params[:album_id])

  	respond_to do |format|
  		format.js
  	end
  end

  def create
  	@photo = Photo.new(photo_params)
  	save_photo_belongs_to

  	respond_to do |format|
  		if @photo.save
  			format.json { render json: { message: "success", photo_id: @photo.id }, status: 200 }
  		else
	    	format.json { render json: { error: @photo.errors.full_messages.join(',') }, status: 400 }
  		end
  	end
  end

  def uploaded
  	@album = Album.find(params[:album_id])
  	@photo = Photo.find(params[:photo_id])

  	respond_to do |format|
  		format.js
  	end
  end

  def destroy
  end

  private

    def photo_params
      params.require(:photo).permit(:image, :description, :func)
  	end

  	def save_photo_belongs_to
  		if params[:album_id]
  			album = Album.find(params[:album_id])
  			@photo.attachable = album
  		end
  	end
end
