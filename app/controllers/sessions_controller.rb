# app/controllers/sessions_controller.rb

class SessionsController < ApplicationController
    def create
        auth = request.env['omniauth.auth']

        user = User.find_or_create_by(discord_id: auth['extra']['raw_info']['id']) do |u|
          u.username = auth['extra']['raw_info']['global_name']
          u.profile_image = auth['info']['image']
          u.discord_id = auth['extra']['raw_info']['id']
          u.user_type = 42
          # Add more fields as needed
        end

        # Check if user is nil and handle the error
        if user.nil?
          # Redirect to root path with an error message, or handle as appropriate
          redirect_to root_path, alert: "User could not be created. Please try again."
          return # This is important to stop execution of the method here
        end

        

        # Store user information in the session
        session[:user_id] = user.id
        session[:username] = user.username

        cookies.encrypted[:user_id] = {
          value: user.id,
          httponly: false, # Important: must be false to be accessible by JavaScript
          expires: 1.week.from_now
        }


        if session[:event_redirect]
          event_path = session.delete(:event_redirect)
          session[:show_modal] = true  # Set a flag to show the modal
          redirect_to event_path
        else
          redirect_to dashboard_path
        end
        
      end

      def destroy
        reset_session
        redirect_to root_path, notice: "You have successfully logged out."
      end
  
    def failure
      redirect_to root_path, alert: "Failed to log in with Discord."
    end
  end
  