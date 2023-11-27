Geocoder.configure(
  # Geocoding options
  timeout: 3,                 # geocoding service timeout (secs)
  lookup: :google,            # name of geocoding service (symbol)
  api_key: ENV['GOOGLE_MAPS'], # API key for geocoding service
  # ... other configuration options ...
)
