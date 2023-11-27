class MapsController < ApplicationController
    def index
        @events = Event.all.as_json(only: [:title, :latitude, :longitude, :description])
        @discords = Discord.all.as_json(only: [:server_name, :latitude, :longitude, :server_description])
      # Convert the data to a suitable format for JavaScript
    end
  end