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
end
