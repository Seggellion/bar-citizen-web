# app/controllers/admin/posts_controller.rb

module Admin
    class EventsController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      
      def index
        @events = Event.all
      end
  
      # ... other CRUD actions ...
    end
  end
  