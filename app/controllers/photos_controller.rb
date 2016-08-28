class PhotosController < ApplicationController

  def create
  	@photo = Photo.new(photo_params)

  	respond_to do |format|
  		if @photo.save
  			render json: { message: "success", fileId: @photo.id }, status: 200
  		else
	    	render json: { error: @photo.errors.full_messages.join(',')}, status: 400
  		end
  	end
  end

  def destroy
  end

  private

    def photo_params
      params.require(:photo).permit(:image, :description, :func)
end
