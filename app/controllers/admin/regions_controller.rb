# app/controllers/admin/posts_controller.rb

module Admin
  class RegionsController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'
    def index
      @regions = Region.where(trashed:nil).order(:created_at).reverse_order
      @users = User.all
    end

    def trash
        
      region = Region.find(params[:id])
      
      region.update(trashed: true, action_id: @current_user.id)
      redirect_to admin_regions_path, notice: 'Event was successfully trashed.'
      # Redirect or render as needed
    end

    # ... other CRUD actions ...
  end
end
