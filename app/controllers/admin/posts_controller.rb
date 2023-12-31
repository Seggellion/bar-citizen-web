# app/controllers/admin/posts_controller.rb

module Admin
    class PostsController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @posts = Post.where(trashed:nil)
      end

      def trash
        
        post = Post.find(params[:id])
        post.update(trashed: true, action_id: @current_user.id)
    
        author = User.find(post.user_id)

        author.update(karma: author.karma - 200, fame: author.fame - 200)
        redirect_to admin_posts_path, notice: 'Post was successfully trashed.'
        # Redirect or render as needed
      end
  
      # ... other CRUD actions ...
    end
  end
  