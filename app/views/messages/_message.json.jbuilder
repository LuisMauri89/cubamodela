json.extract! message, :id, :title, :body, :footer, :ownerable_id, :ownerable_type, :asociateable_id, :asociateable_type, :created_at, :updated_at
json.url message_url(message, format: :json)