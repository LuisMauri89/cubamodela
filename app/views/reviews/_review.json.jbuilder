json.extract! review, :id, :fromable_id, :fromable_type, :toable_id, :toable_type, :review_en, :review_es, :created_at, :updated_at
json.url review_url(review, format: :json)