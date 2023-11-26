# app/controllers/admin/posts_controller.rb

module Admin
  class DiscordsController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'
    def index
      @discords = Discord.all
    end

    # ... other CRUD actions ...
  end
end
