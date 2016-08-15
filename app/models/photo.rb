class Photo < ApplicationRecord
  # Associations
  belongs_to :attachable, polymorphic: true

  # Image
  has_attached_file :image, styles: { user: "32x32", profile: "128x128", list: "64x64" }
end
