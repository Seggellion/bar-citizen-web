# app/controllers/forum/replies_controller.rb
module Forum
    class RepliesController < ApplicationController
      before_action :set_post
  
      def new
        @reply = @post.replies.new
      end
  
      def create
        @reply = @post.replies.new(reply_params)
        @reply.user = current_user # assuming you have a current_user method
  
        if @reply.save
          redirect_to forum_post_category_post_path(@post.post_category, @post), notice: 'Reply was successfully created.'
        else
          render :new
        end
      end
  
      private
  
      def set_post
        @post = Post.find(params[:post_id])
      end
  
      def reply_params
        params.require(:reply).permit(:content)
      end
    end
  end
  