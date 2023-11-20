# app/controllers/admin/posts_controller.rb

module Admin
    class UsersController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @users = User.all
      end
  
      # ... other CRUD actions ...
    end
  end
  