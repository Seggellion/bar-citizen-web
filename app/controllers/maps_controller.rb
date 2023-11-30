class MapsController < ApplicationController
    def index
        @events = Event.all.as_json(only: [:title, :latitude, :longitude, :description])
        @regions = Region.all.as_json(only: [:name, :latitude, :longitude, :description])
      # Convert the data to a suitable format for JavaScript
    end
  end