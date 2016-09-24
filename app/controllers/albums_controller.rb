class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_album, only: [:edit, :update, :delete, :destroy]

  def index
    @albums = current_user.profileable.albums

    respond_to do |format|
      format.js
    end
  end
  
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
  	respond_to do |format|
  		format.js
  	end
  end

  def update
  	respond_to do |format|
      if can_update_or_delete?
    		if @album.update_attributes(album_params)
    			format.js
    		else
    			format.js
    		end
      else
        format.js
      end
  	end
  end

  def delete
    can_update_or_delete?

    respond_to do |format|
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if can_update_or_delete?
        if @album.destroy
          format.js
        else
          format.js
        end
      else
        format.js
      end
    end
  end

  private

    def album_params
      params.require(:album).permit(:name)
    end

    def set_album
      @album = Album.find(params[:id])
    end

    def can_update_or_delete?
      default_values = ["Profile Photo", "Profesional Book", "Polaroid"]
      if default_values.include?(@album.name)
        @album.errors[:base] << "SORRY, this album can't be updated or removed."
        return false
      else
        return true
      end
    end
end
