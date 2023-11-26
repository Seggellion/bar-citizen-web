class RegionsController < ApplicationController
    # POST /regions
    def create
      @region = Region.new(region_params)
      @region.user_id = current_user.id

      if @region.save
        redirect_to admin_regions_path, notice: 'Region was successfully created.'
      else
        redirect_to admin_regions_path, notice: 'Region not created.'
      end
    end
  
    private
      # Only allow a list of trusted parameters through.
      def region_params
        params.require(:region).permit(:name, :profile_image)
      end
  end
  