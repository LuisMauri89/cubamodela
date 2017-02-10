class StaticPagesController < ApplicationController
  layout 'home_layout', only: [:home]

  def home
  end

  def help
  end

  def contact
  end

  def aboutus
  end

  def xuan
  end

  def camila
  end

  def patricio
  end

  def profile_example
  end

  def gallery
  end

  def show_gallery_photo
    @i = params[:i]
  end

  def casting_flow
    respond_to do |format|
      format.js
    end
  end

  def booking_flow
    respond_to do |format|
      format.js
    end
  end

  def profiles_flow
    respond_to do |format|
      format.js
    end
  end

  def coupons_flow
    respond_to do |format|
      format.js
    end
  end
end
