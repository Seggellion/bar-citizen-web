# app/controllers/admin/blocks_controller.rb
module Admin
    class UserBadgesController < ApplicationController

        before_action :authenticate_admin!
        layout 'admin'
        def index
          @user_badges = UserBadge.all
         # @user_badges = UserBadge.where(trashed:nil)
        end
  
        def trash
          
          message = UserBadge.find(params[:id])
         # message.update(trashed: true, action_id: @current_user.id)
      
          author = User.find(message.user_id)
  
          redirect_to admin_user_badges_path, notice: 'UserBadge was successfully trashed.'
          # Redirect or render as needed
        end

    # POST /user_badges
    def create

        @user_badge = UserBadge.new(user_badge_params)


  
        if @user_badge.save
          redirect_to admin_user_badges_path, notice: 'UserBadge was successfully created.'
        else
          redirect_to admin_user_badges_path, notice: 'UserBadge not created'
        end
      end
    
      private
        # Only allow a list of trusted parameters through.
        def user_badge_params
          params.require(:user_badge).permit(:user_id, :badge_id)
        end



    end
end