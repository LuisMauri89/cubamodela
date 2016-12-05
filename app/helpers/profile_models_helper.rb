module ProfileModelsHelper

	def get_range_of_shoe_sizes
		sizes = [2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0, 10.5, 11.0, 11.5, 12.0, 12.5, 13.0, 13.5, 14.0, 14.5, 15.0, 15.5, 16.0]
		sizes = sizes.collect{ |size| [get_printable_size(size), size] }
	end

	def get_range_of_cloth_sizes
		sizes = [2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0, 10.5, 11.0, 11.5, 12.0, 12.5, 13.0, 13.5, 14.0, 14.5, 15.0, 15.5, 16.0]
		sizes = sizes.collect{ |size| [get_printable_size(size), size] }
	end

	def get_printable_size(size)
		if (size - size.to_i) > 0
			return size.to_i.to_s << " (1/2)"
		else
			return size.to_i.to_s
		end
	end

	def get_genders_for_search
		genders = [[t('activerecord.attributes.profile_model.gender_female'), "Female"], [t('activerecord.attributes.profile_model.gender_male'), "Male"]]

		return genders
	end

	def get_people_can_vote
		return Constant::PEOPLE_CAN_VOTE
	end

	def get_btn_warning_text(profile)
		warning_text = I18n.t('forms.buttons.warning') << " (" << profile.warnings_count.to_s << ")"

		if profile.warnings_last_made.present? && profile.warnings_count > 0
			warning_text << " [" << @profile.warnings_last_made << "]"
		else
			warning_text << " [" << I18n.t('views.profile_models.show.admin.no_warning_made_text') << "]"
		end

		return warning_text
	end
end
