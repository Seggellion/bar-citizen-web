# app/controllers/admin/posts_controller.rb

module Admin
    class RepliesController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @replies = Reply.where(trashed:nil)
      end
  
      def trash
        
        reply = Reply.find(params[:id])
        reply.update(trashed: true, action_id: @current_user.id)
    
        author = User.find(reply.user_id)
        author.update(karma: author.karma - 200, fame: author.fame - 200)
        redirect_to admin_replies_path, notice: 'Reply was successfully trashed.'
        # Redirect or render as needed
      end

      # ... other CRUD actions ...
    end
  end
  