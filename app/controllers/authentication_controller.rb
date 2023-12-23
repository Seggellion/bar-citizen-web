
  
  # app/controllers/authentication_controller.rb
  class AuthenticationController < ApplicationController
    skip_before_action :verify_authenticity_token

    def discord_callback
      code = params[:code]
      token = exchange_code_for_token(code, code_verifier)
      user_info = fetch_user_info(token)
      user = find_or_create_user(user_info)

      # Generate a session token or JWT
      #session_token = generate_session_token(user)
      jwt = generate_jwt(user)
      render json: { jwt: jwt }
  
      # Send token to Flutter app (consider a secure method to do this)
     # render json: { token: session_token }
    end

    def redirect_to_discord
        client_id = ENV['MOBILE_DISCORD_CLIENT_ID']
        redirect_uri = CGI.escape('https://carcitizen.altama.energy/api/discord/callback')
        scope = 'identify email'
    
        oauth_url = "https://discord.com/api/oauth2/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}"
        redirect_to oauth_url, allow_other_host: true
      end

    # app/controllers/authentication_controller.rb
    def exchange_token
    code = params[:code]
    code_verifier = params[:code_verifier]
    token = exchange_code_for_token(code, code_verifier)
    Rails.logger.info "exchange token: #{code_verifier}"
    # respond with the token or an error message
    end
  
    private
  
    def exchange_code_for_token(code, code_verifier)
      request_body = {
        client_id: ENV['MOBILE_DISCORD_CLIENT_ID'],
        client_secret: ENV['MOBILE_DISCORD_SECRET_ID'],
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: 'https://carcitizen.altama.energy/api/discord/callback',
        code_verifier: code_verifier  # Include the code_verifier
      }
    
      response = HTTParty.post("https://discord.com/api/oauth2/token", body: request_body, headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
    
      Rails.logger.info "Access Token Response: #{response.inspect}"
    
      response.parsed_response['access_token']
    end
    
  
    def fetch_user_info(token)
      # Fetch user information from Discord
      Rails.logger.info "Discord User Info Response: #{response.parsed_response}"

      response = HTTParty.get("https://discord.com/api/users/@me", headers: {
        'Authorization' => "Bearer #{token}"
      })
  
      response.parsed_response
    end
  
    def find_or_create_user(user_info)
      # Find or create a user in your database
      user = User.find_or_create_by(discord_id: user_info['id']) do |u|
        u.username = user_info['username']
        u.profile_image = user_info['avatar']
        u.discord_id = user_info['id']
        u.user_type = 42
        # Set other user attributes...
      end
      Rails.logger.info "User Info to Process: #{user_info}"
      user
    end

  
    def generate_jwt(user)
      Rails.logger.info "Generating JWT for User: #{user.inspect}"

      # Generate a session token or JWT
      payload = {
        user_id: user.id,
        username: user.username,
        exp: 72.hours.from_now.to_i, # Set an expiration time
        # ... any other payload data ...
      }
  
      secret = Rails.application.secrets.secret_key_base
      token = JWT.encode(payload, secret, 'HS256')
  
      token
   
    end
  end
  