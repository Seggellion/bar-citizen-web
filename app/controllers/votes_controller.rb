class VotesController < ApplicationController
    before_action :authenticate_user!
    
    before_action :find_votable
  
    def create
      vote = @votable.votes.where(user: current_user).first_or_initialize
      vote.upvote = params[:upvote]
      if vote.save
        redirect_to @votable.photo, notice: 'Comment was upvoted'
      else
        # handle error
      end
    end
  
    private
    def authenticate_user!
        redirect_to login_path, alert: 'You must be logged in to perform this action.' if current_user.nil?
      end
    def find_votable
      @votable = params[:votable_type].constantize.find(params[:votable_id])
    end
  end