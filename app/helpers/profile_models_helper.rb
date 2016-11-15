module ProfileModelsHelper

	def get_range_of_shoe_sizes
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
end
