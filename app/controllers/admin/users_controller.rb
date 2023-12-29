# app/controllers/admin/posts_controller.rb

module Admin
    class UsersController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @users = User.all.order(Arel.sql("last_login IS NULL, last_login DESC"))
      end
  
      def update_user_level
        @user = User.find(params[:id])
        @user.action_id = current_user.id
        if @user.update(user_params)
          # Handle a successful update.
          redirect_to admin_users_path, notice: 'User level was successfully updated.'
        else
          # Handle error.
          render :edit
        end
      end
    

      # ... other CRUD actions ...

      def trash
        
        user = User.find(params[:id])
        
        user.update(trashed: true, action_id: @current_user.id, user_type:69)
        redirect_to admin_users_path, notice: 'User is trash'
        # Redirect or render as needed
      end


      private

      def user_params
        params.require(:user).permit(:user_type)
      end


    end
  end
  