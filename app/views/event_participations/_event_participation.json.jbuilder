json.extract! event_participation, :id, :user_id, :event_id, :badge_count, :created_at, :updated_at
json.url event_participation_url(event_participation, format: :json)
