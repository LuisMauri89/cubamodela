# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.cubamodela.com"
SitemapGenerator::Sitemap.create_index = true

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  

  add static_pages_home_path, :priority => 1
  add static_pages_contact_path, :priority => 1
  add static_pages_xuan_path
  add static_pages_camila_path
  add static_pages_patricio_path
  add static_pages_profile_example_path
  add static_pages_gallery_path, :priority => 1

  add profile_models_path, :priority => 1
  add profile_photographers_path, :priority => 1
  add castings_path, :priority => 1
  add bookings_path, :priority => 1

  ProfileModel.find_each do |m|
    add profile_model_path(m), :lastmod => m.updated_at, :priority => 0.75
  end

  ProfilePhotographer.find_each do |p|
    add profile_photographer_path(p), :lastmod => p.updated_at, :priority => 0.75
  end

  ProfileContractor.find_each do |c|
    add profile_contractor_path(c), :lastmod => c.updated_at, :priority => 0.75
  end

  Casting.find_each do |c|
    add casting_path(c), :lastmod => c.updated_at
  end

  Booking.find_each do |b|
    add booking_path(b), :lastmod => b.updated_at
  end
end
