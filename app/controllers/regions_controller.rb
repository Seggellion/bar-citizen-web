class RegionsController < ApplicationController
    # POST /regions

    def index
      @regions = Region.all
      render json: @regions
    end

    def show
      @region = Region.find_by_slug(params[:id])
      @posts = @region.post_category&.posts
      @regional_events = @region.events
    end

    def create
      @region = Region.new(region_params)

      if @region.save
        Activity.create(name: "New region created", description: "region-id_#{@region.id}", user_id: @region.user_id)
        redirect_to admin_regions_path, notice: 'Region was successfully created.'
      else
        redirect_to admin_regions_path, notice: 'Region not created.'
      end
    end
  
    def update
      @region = Region.find_by_slug(params[:id])
      respond_to do |format|
        if @region.update(region_params)
          format.html { redirect_to region_url(@region), notice: "Region was successfully updated." }
          format.json { render :show, status: :ok, location: @region }
        else
          format.html { redirect_to region_url(@region), notice: "Region was not successfully updated." }
          format.json { render json: @region.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      # Only allow a list of trusted parameters through.
      def region_params
        params.require(:region).permit(:name, :logo_image, :description, :banner, :image_01, :image_02, :city, :user_id)
      end
  end
  