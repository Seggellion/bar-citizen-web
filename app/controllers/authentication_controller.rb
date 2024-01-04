
  
  # app/controllers/authentication_controller.rb
  class AuthenticationController < ApplicationController
    skip_before_action :verify_authenticity_token

    CLIENT_SECRET = ENV['MOBILE_DISCORD_CLIENT_SECRET']

    CLIENT_ID = ENV['MOBILE_DISCORD_CLIENT_ID']
    REDIRECT_URI = 'http://192.168.4.108:3000/api/discord/callback'  # Change this to your production URI when needed
  
    # This method starts the Discord OAuth process
    def start_auth
      # Define the Discord OAuth URL with required query parameters
      discord_oauth_url = "https://discord.com/api/oauth2/authorize?" +
                          "client_id=#{CLIENT_ID}&" +
                          "redirect_uri=#{CGI.escape(REDIRECT_URI)}&" +
                          "response_type=code&" +
                          "scope=identify%20email"  # Add other scopes as needed
  
      # Redirect the client to Discord's OAuth endpoint
      redirect_to discord_oauth_url, allow_other_host: true
     
    end


    def discord_callback
      # Exchange the code for a token
      response = exchange_code_for_token(params[:code])

      if response['access_token']
        # Fetch user information from Discord
        user_info = fetch_user_info(response['access_token'])

        # Find or create a user in your database
        # This is pseudo-code; implement according to your user model and database setup
        user = User.find_or_create_by(discord_id: user_info['id']) do |u|
          u.username = user_info['username']
          # ... any other user fields ...
        end
  
        # Generate a JWT for the user
        token = generate_jwt(user)
  
        # Respond to the client with the JWT
        app_deep_link_uri = "deeplinktest://oauth2redirect?token=#{token}"

        # Redirect to the app with the token
        redirect_to app_deep_link_uri, allow_other_host: true
      else
        # Handle errors or issues with the token exchange
        render json: { error: 'Failed to authenticate with Discord' }, status: :unauthorized
      end
    end


    def discord_callback_old_deleteme
      Rails.logger.info "Received parameters: #{params}"
      code = params[:code]
      code_verifier = params[:code_verifier]  # Ensure this line is present to extract the code_verifier from parameters
  
      if code && code_verifier
        token = exchange_code_for_token(code, code_verifier)
        user_info = fetch_user_info(token)
        user = find_or_create_user(user_info)
  
        # Generate a session token or JWT
        jwt = generate_jwt(user)
        render json: { jwt: jwt }
      else
        # Handle the error if code or code_verifier are missing
        render json: { error: 'Missing code or code_verifier' }, status: :bad_request
      end
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
      Rails.logger.info "exchange token initialized"
      code = params[:code]
      code_verifier = params[:code_verifier]
      token = exchange_code_for_token(code, code_verifier)
    end
  
    private
  
    def exchange_code_for_token_old(code, code_verifier)
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
  
    
    
  # Helper method to exchange the code for a token
  def exchange_code_for_token(code)
    uri = URI('https://discord.com/api/oauth2/token')
    response = Net::HTTP.post_form(uri, {
      'client_id' => CLIENT_ID,
      'client_secret' => CLIENT_SECRET,
      'grant_type' => 'authorization_code',
      'code' => code,
      'redirect_uri' => REDIRECT_URI
    })
    JSON.parse(response.body)
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
  