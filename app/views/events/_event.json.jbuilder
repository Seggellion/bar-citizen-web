json.extract! event, :id, :title, :description, :start_datetime, :location, :region, :social_media_links, :discord_link, :creator_id, :created_at, :updated_at
json.url event_url(event, format: :json)
