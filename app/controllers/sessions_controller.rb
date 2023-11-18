# app/controllers/sessions_controller.rb

class SessionsController < ApplicationController
    def create
        auth = request.env['omniauth.auth']
        user = User.find_or_create_by(discord_id: auth['uid']) do |u|
          u.username = auth['info']['name']
          # Add more fields as needed
        end
    
        # Store user information in the session
        session[:user_id] = user.id
        session[:username] = user.username
    
        redirect_to user_dashboard_path
      end

      def destroy
        reset_session
        redirect_to root_path, notice: "You have successfully logged out."
      end
  
    def failure
      redirect_to root_path, alert: "Failed to log in with Discord."
    end
  end
  