# app/controllers/admin/posts_controller.rb

module Admin
    class PostsController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @posts = Post.all
      end
  
      # ... other CRUD actions ...
    end
  end
  