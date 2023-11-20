# app/controllers/admin/posts_controller.rb

module Admin
    class PhotosController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @photos = Photo.all
      end
  
      # ... other CRUD actions ...
    end
  end
  