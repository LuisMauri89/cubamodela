module MessagesHelper
	def get_active_class(index)
		return index == 0 ? "active" : ""
	end

	def get_readed_class(message)
		return message.readed ? "" : "inbox-message-unreaded-bkg"
	end
end
