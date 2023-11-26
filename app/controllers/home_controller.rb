class HomeController < ApplicationController
  def index
    redirect_to dashboard_path if user_signed_in?

     @next_events = Event.where("start_datetime >= ?", Date.today)
    .order(:start_datetime)
    .limit(5)
    @newest_events = Event.where("start_datetime >= ?", Date.today).order(:created_at)

  end

  
  def dashboard
    
    # Ensure that the user is authenticated before showing the dashboard
    redirect_to root_path unless user_signed_in?
current_user.update(last_login: DateTime.now)
    @username = current_user.username
    # Load more user data as needed
  end
end
