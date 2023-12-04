# app/controllers/admin/posts_controller.rb

module Admin
    class UsersController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @users = User.all
      end
  
      # ... other CRUD actions ...

      def trash
        
        user = User.find(params[:id])
        
        user.update(trashed: true, action_id: @current_user.id, user_type:69)
        redirect_to admin_users_path, notice: 'User is trash'
        # Redirect or render as needed
      end

    end
  end
  