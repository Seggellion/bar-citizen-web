
  
  # app/controllers/authentication_controller.rb
  class AuthenticationController < ApplicationController
    def discord_callback
      code = params[:code]
      token = exchange_code_for_token(code)
      user_info = fetch_user_info(token)
      user = find_or_create_user(user_info)
  
      # Generate a session token or JWT
      session_token = generate_session_token(user)
  
      # Send token to Flutter app (consider a secure method to do this)
      render json: { token: session_token }
    end


    def redirect_to_discord
        client_id = ENV['DISCORD_CLIENT_ID']
        redirect_uri = 'https://barcitizen.altama.energy/auth/discord/callback'
        scope = 'identify email'
    
        oauth_url = "https://discord.com/api/oauth2/authorize?client_id=#{client_id}&redirect_uri=#{URI.encode(redirect_uri)}&response_type=code&scope=#{scope}"
        redirect_to oauth_url
      end
  
    private
  
    def exchange_code_for_token(code)
      # Exchange the code for a token
      response = HTTParty.post("https://discord.com/api/oauth2/token", body: {
        client_id: ENV['DISCORD_CLIENT_ID'],
        client_secret: ENV['DISCORD_CLIENT_SECRET'],
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: 'http://your-backend.com/auth/discord/callback'
      }, headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
  
      response.parsed_response['access_token']
    end
  
    def fetch_user_info(token)
      # Fetch user information from Discord
      response = HTTParty.get("https://discord.com/api/users/@me", headers: {
        'Authorization' => "Bearer #{token}"
      })
  
      response.parsed_response
    end
  
    def find_or_create_user(user_info)
      # Find or create a user in your database
      User.find_or_create_by(discord_id: user_info['id']) do |u|
        u.username = auth['extra']['raw_info']['global_name']
        u.profile_image = auth['info']['image']
        u.discord_id = auth['extra']['raw_info']['id']
        u.user_type = 42
        # Set other user attributes...
      end
    end
  
    def generate_session_token(user)
      # Generate a session token or JWT
      # This is highly dependent on your authentication setup (e.g., Devise, JWT)
    end
  end
  