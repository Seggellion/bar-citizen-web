class GiveawaysController < ApplicationController
    before_action :set_event
    before_action :set_giveaway, only: [:show, :edit, :update, :destroy, :draw_winner]
  
    def index
      @giveaways = @event.giveaways
    end
  
    def new
      @giveaway = Giveaway.new
    end
  
def show

end

def edit

end

def update

end

    def create
        
        @giveaway = @event.giveaways.build(giveaway_params.merge(creator: current_user))

      if @giveaway.save
        Activity.create(name: "New giveaway added", description: "giveaway-id_#{@giveaway.id}", user_id: current_user.id)
        redirect_to event_path(@event), notice: 'Giveaway was successfully created.'
      else
        redirect_to event_path(@event), notice: 'Giveaway not created.'
      end
    end
  
    def draw_winner
        # IDs of users who have already won in this event
        previous_winners_ids = @event.giveaways.where.not(winner_id: nil).pluck(:winner_id)
      
        # Filter out previous winners from the array of attendees
        eligible_attendees = @event.attendees.reject { |attendee| previous_winners_ids.include?(attendee.id) }
      
        # Select a random winner from eligible attendees
        winner = eligible_attendees.sample
      
        if winner
          @giveaway.update(winner_id: winner.id)
          # Additional logic to notify the winner or handle the aftermath
          redirect_to event_path(@event), notice: "Winner successfully drawn."
        else
          redirect_to event_path(@event), alert: "No eligible attendees to draw from."
        end
      end
      
      
  
    def destroy
      @giveaway.destroy
      redirect_to event_giveaways_path(@event), notice: 'Giveaway was successfully destroyed.'
    end
  
    private
  
    def set_event
     
      @event = Event.find(params[:event_id])
    end
  
    def set_giveaway
        
      @giveaway = Giveaway.find(params[:id])
    end
  
    def giveaway_params
      params.require(:giveaway).permit(:title, :description, :event_id, :user_id)
    end
  end
  