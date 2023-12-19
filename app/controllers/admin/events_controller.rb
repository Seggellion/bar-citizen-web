# app/controllers/admin/events_controller.rb

module Admin
    class EventsController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      
      def index
        @unpublished_events = Event.where(published:nil)
      end

      def all
        @events = Event.all
      end

    

      def publish

        event = Event.find_by_slug(params[:id])

        event.update(published: true, action_id: current_user.id)
    
 
        Activity.create(name: "Created event", description: "event-id_#{event.id}", user_id: event.creator_id)

        redirect_to admin_events_path, notice: 'Event was successfully approved.'

      end
    
      def trash
        
        event = Event.find_by_slug(params[:id])
        event.update(trashed: true, action_id: @current_user.id)
    
        author = User.find(event.author_id)
        author.update(karma: author.karma - 200, fame: author.fame - 200)
        redirect_to admin_events_path, notice: 'Event was successfully trashed.'
        # Redirect or render as needed
      end
  
      # ... other CRUD actions ...
    end
  end
  