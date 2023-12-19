class VotesController < ApplicationController
    before_action :authenticate_user!
    
    before_action :find_votable
  
    def create
      vote = @votable.votes.where(user: current_user).first_or_initialize
      vote.upvote = params[:upvote]
      if vote.save

        redirect_to appropriate_redirect_path, notice: 'Item upvoted!'

      else
        # handle error
      end
    end
  
    private
    def authenticate_user!
        redirect_to login_path, alert: 'You must be logged in to perform this action.' if current_user.nil?
      end
      
      def find_votable
        klass = params[:votable_type].classify.constantize
        @votable = klass.find(params[:votable_id])
      rescue NameError
        # handle the case where the class does not exist
      end

      def appropriate_redirect_path
        case @votable
        when Photo
          photo_path(@votable)
        when PhotoComment
          photo_path(@votable.photo)
        else
          # Handle other votable types or default redirect
        end
      end

      
  end