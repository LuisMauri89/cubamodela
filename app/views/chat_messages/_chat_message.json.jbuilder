json.extract! chat_message, :id, :body, :ownerable_id, :ownerable_type, :fromable_id, :fromable_type, :parent_id, :created_at, :updated_at
json.url chat_message_url(chat_message, format: :json)