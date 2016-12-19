class Photo < ApplicationRecord
  # Associations
  belongs_to :attachable, polymorphic: true

  # Image
  has_attached_file :image, styles: { 
	  					original:{
	  						:processors => [:watermark],
							:watermark_path => "#{Rails.root}/app/assets/images/watermark.png",
							:position => 'SouthEast',
							:watermark_dissolve => 90,
							:auto_orient => false 
	  					},
	  					user: "32x32", 
	  					profile: "128x128", 
	  					list: "64x64", 
	  					large: "256x256" 
  					}, 
  					:default_url => "/images/missing.JPG"

  # Validations
  validates_attachment :image, :presence => true,
							   :content_type => { :content_type => /^image\/(jpeg|jpg|png|gif)$/ },
							   :size => { :in => 0..30.megabytes }
end
