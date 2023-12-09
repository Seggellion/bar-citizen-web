class PhotoCommentsController < ApplicationController
    before_action :set_photo
  
    def create
      @comment = @photo.photo_comments.new(photo_comment_params)
      @comment.user = current_user # Assuming you have a current_user method
  
      if @comment.save
        redirect_to @photo, notice: 'Comment was successfully created.'
      else
        redirect_to @photo, alert: 'There was a problem creating your comment.'
      end
    end
  
  
    def upvote
      vote = @photo_comment.votes.find_or_initialize_by(user: current_user)
      unless vote.persisted?
        vote.update(upvote: true)
      end
      redirect_back(fallback_location: root_path)
    end
  
    def downvote
      vote = @photo_comment.votes.find_or_initialize_by(user: current_user)
      unless vote.persisted?
        vote.update(upvote: false)
      end
      redirect_back(fallback_location: root_path)
    end
  

    private
  
    def set_photo
      @photo = Photo.find(params[:photo_id])
    end
  
    def photo_comment_params
      params.require(:photo_comment).permit(:content)
    end
  end
  