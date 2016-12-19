class ReprocessImagesJob < ApplicationJob
  queue_as :default

  def perform()
    Photo.each do |photo|
		photo.image.reprocess!
	end
  end
end
