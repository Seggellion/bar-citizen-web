# app/controllers/api/events_controller.rb
module Api
    class EventsController < ApplicationController
      def index
        @events = Event.where(published: true)
        render json: @events
      end
    end
  end
  