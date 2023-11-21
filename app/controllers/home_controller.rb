class HomeController < ApplicationController
  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
    
    # Ensure that the user is authenticated before showing the dashboard
    redirect_to root_path unless user_signed_in?
current_user.update(last_login: DateTime.now)
    @username = current_user.username
    # Load more user data as needed
  end
end
