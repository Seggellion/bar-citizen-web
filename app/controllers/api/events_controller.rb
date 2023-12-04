# app/controllers/api/events_controller.rb
module Api
    class EventsController < ApplicationController
      def index
        @events = Event.all
        render json: @events
      end
    end
  end
  