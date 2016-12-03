class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_album, only: [:edit, :update, :delete, :destroy]
  before_action :check_if_can, only: [:index, :edit, :update, :delete, :destroy]

  def index
    begin
      @albums = current_user.profileable.albums
    rescue
      @albums = []
    end

    respond_to do |format|
      format.js
    end
  end
  
  def new
  	@album = Album.new

    authorize! :new, @album

  	respond_to do |format|
  		format.js
  	end
  end

  def create
  	@album = Album.new(album_params)
  	@album.profileable = current_user.profileable

    authorize! :create, @album

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
    		if @album.update(album_params)
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
      default_values = Constant::ALBUMS_DEFAULT_VALUES
      if default_values.include?(@album.name)
        @album.errors[:base] << I18n.t('views.albums.messages.edit.edit_or_remove')
        return false
      else
        return true
      end
    end

    def check_if_can
      @album ||= Album.new
      authorize! action_name.to_s.to_sym, @album
    end
end
