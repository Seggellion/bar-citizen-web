

class ApplicationController < ActionController::Base
    helper_method :current_user, :user_signed_in?
    protect_from_forgery with: :exception
    before_action :set_locale
    before_action :set_message

    helper_method :message
  

    def set_locale
      session[:locale] = params[:locale] if params[:locale].present?
      I18n.locale = session[:locale] || I18n.default_locale
    end

    private

    def authenticate_admin!
   
      if current_user.nil? || current_user.user_type > 1
        redirect_to root_path, alert: "You are not authorized to access this section."
      end
    end    

    def current_user
      # Assuming the user's ID is stored in the session under :user_id after successful authentication
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def user_signed_in?
      current_user.present?
    end
  
    def set_message
      @message = Message.new
    end
  
    def message
      @message
    end
    
  end
  