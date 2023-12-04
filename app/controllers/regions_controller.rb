class RegionsController < ApplicationController
    # POST /regions

    def index
      @regions = Region.all
      render json: @regions
    end

    def create
      @region = Region.new(region_params)

      if @region.save
        Activity.create(name: "New Region created", description: "region-id_#{@region.id}", user_id: @region.user_id)
        redirect_to admin_regions_path, notice: 'Region was successfully created.'
      else
        redirect_to admin_regions_path, notice: 'Region not created.'
      end
    end
  
    private
      # Only allow a list of trusted parameters through.
      def region_params
        params.require(:region).permit(:name, :logo_image, :city, :user_id)
      end
  end
  