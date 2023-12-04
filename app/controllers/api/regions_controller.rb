# app/controllers/api/regions_controller.rb
module Api
    class RegionsController < ApplicationController
      def index
        @regions = Region.all
        render json: @regions
      end
    end
  end
  