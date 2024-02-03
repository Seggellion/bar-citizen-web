class WallCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_wall_comment, only: [:destroy]
  
    # POST /wall_comments
    def create
        
      @wall_comment = WallComment.new(wall_comment_params)
      @wall_comment.commenter = current_user
  
      if @wall_comment.save
        redirect_to user_path(@wall_comment.owner), notice: 'Comment was successfully posted.'
        Activity.create(name: "Wall commented", description: "comment-id_#{@wall_comment.id}", user_id: current_user.id)
      else
        # Handle the error, e.g., render the page with the form again
        flash[:alert] = 'Error posting comment.'
        redirect_to user_path(@wall_comment.owner)
      end
    end
  
    # DELETE /wall_comments/1
    def destroy

        @wall_comment = WallComment.find(params[:id])
        owner_id = @wall_comment.owner_id
      
        if @wall_comment.commenter == current_user || @wall_comment.owner == current_user
          @wall_comment.destroy
          redirect_to user_path(owner_id), notice: 'Comment was successfully deleted.'
        else
          redirect_to user_path(owner_id), alert: 'You do not have permission to delete this comment.'
        end
    end
    
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_wall_comment
      @wall_comment = WallComment.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def wall_comment_params
      params.require(:wall_comment).permit(:content, :owner_id)
    end
  
    # A method to authenticate the user (ensure it's implemented in your application)
    
    def authenticate_user!
        redirect_to login_path, alert: 'You must be logged in to perform this action.' if current_user.nil?
      end
  end
  