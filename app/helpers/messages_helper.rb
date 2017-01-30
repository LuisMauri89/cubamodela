module MessagesHelper
	def get_active_class(index)
		return index == 0 ? "active" : ""
	end

	def get_readed_class(message)
		return message.readed ? "" : "inbox-message-unreaded-bkg"
	end

	def get_btn_action_state(count)
		return count == 0 ? " disabled" : ""
	end
end
