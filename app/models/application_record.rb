class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_missing_profile_picture(size)
  	case size
  	when "tiny".to_sym
  		return "missing_profile_picture_32.png"
  	when "small".to_sym
  		return "missing_profile_picture_64.png"
  	when "medium".to_sym
  		return "missing_profile_picture_128.png"	
  	end
  end
end
