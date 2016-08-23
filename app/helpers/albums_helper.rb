module AlbumsHelper
	def can_update_or_delete?(album)
      default_values = ["Profile Photo", "Profesional Book", "Polaroid"]
      if default_values.include?(album.name)
        return false
      else
        return true
      end
    end
end
