# app/controllers/admin/posts_controller.rb

module Admin
  class RegionsController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'
    def index
      @regions = Region.all
    end

    # ... other CRUD actions ...
  end
end
