json.extract! photo, :id, :event_id, :user_id, :image_url, :upvotes, :downvotes, :favorites_count, :created_at, :updated_at
json.url photo_url(photo, format: :json)
