class HomeController < ApplicationController
  
  def index
    @page = Page.find_by(title: 'homepage')

     @next_events = Event.where("start_datetime >= ?", Date.today)
    .order(:start_datetime)
    .limit(5)
    @newest_events = Event.where("start_datetime >= ?", Date.today).order(:created_at)
    @activities = Activity.all.order(:created_at).reverse_order
  end


  def gallery
@photos = Photo.where(published:true)
  end
  
  def dashboard
    if !user_signed_in? || current_user.user_type == User::TRASH
      redirect_to root_path and return
    end
    # Ensure that the user is authenticated before showing the dashboard
    current_user.update(last_login: DateTime.now)
    @username = current_user.username
    @activities = Activity.all.order(:created_at).reverse_order
    # Load more user data as needed
  end
end
