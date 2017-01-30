module AlbumsHelper
	def can_update_or_delete?(album)
      if Constant::ALBUMS_DEFAULT_VALUES.include?(album.name)
        return false
      else
        return true
      end
    end
end
