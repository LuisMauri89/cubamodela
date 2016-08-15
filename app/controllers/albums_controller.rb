class AlbumsController < ApplicationController
  def new
  	@album = Album.new

  	respond_to do |format|
  		format.js
  	end
  end

  def create
  	@album = Album.new(album_params)
  	@album.profileable = current_user.profileable

  	respond_to do |format|
  		if @album.save
  			format.js
  		else
  			format.js
  		end
  	end
  end

  def edit
  	@album = Album.find(params[:id])

  	respond_to do |format|
  		format.js
  	end
  end

  def update
  	@album = Album.find(params[:id])
  	@old_value_name = @album.name

  	respond_to do |format|
  		if @album.update_attributes(album_params)
  			format.js
  		else
  			format.js
  		end
  	end
  end

  def destroy
    @album = Album.find(params[:id])
    
    respond_to do |format|
      if @album.destroy
        format.js
      else
        format.js
      end
    end
  end

  private

    def album_params
      params.require(:album).permit(:name)
    end
end
