class EventManagersController < ApplicationController
    # POST /event_managers

    before_action :set_event_manager, only: [:destroy]

    def index
      @event_managers = EventManager.all
      render json: @event_managers
    end

    def create

      @event_manager = EventManager.new(event_manager_params)
      event = Event.find_by_id(params[:event_id])
      @event_manager.update(event_id: event.id)

      if @event_manager.save
     #   Activity.create(name: "New EventManager created", description: "event_manager-id_#{@event_manager.id}", user_id: @event_manager.user_id)
        redirect_to event_url(event), notice: 'EventManager was successfully created.'
      else
        redirect_to event_url(event), notice: 'EventManager not created.'
      end
    end
  

    def destroy
        
        @event_manager.destroy!

        respond_to do |format|
          format.html { redirect_to event_url(@event_manager.event), notice: "Successfully removed manager .." }     
          format.json { head :no_content }
        end
      end
    

    private
      # Only allow a list of trusted parameters through.
      
  def set_event_manager
    @event_manager = EventManager.find_by_id(params[:id])
  end

      def event_manager_params
        params.require(:event_managers).permit(:user_id, :event_id)
      end
  end
  