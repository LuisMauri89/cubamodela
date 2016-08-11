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
end
