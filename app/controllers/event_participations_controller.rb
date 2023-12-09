class EventParticipationsController < ApplicationController
  before_action :set_event_participation, only: %i[ show edit update destroy ]

  # GET /event_participations or /event_participations.json
  def index
    @event_participations = EventParticipation.all
  end

  # GET /event_participations/1 or /event_participations/1.json
  def show
  end

  # GET /event_participations/new
  def new
    @event_participation = EventParticipation.new
  end

  # GET /event_participations/1/edit
  def edit
  end

  # POST /event_participations or /event_participations.json
  def create
    @event_participation = EventParticipation.new(event_participation_params)

    respond_to do |format|
      if @event_participation.save
        Activity.create(name: "#{current_user.username} joined event", description: "event-id_#{@event.id}", user_id: current_user.id)
        format.html { redirect_to event_url(@event_participation.event), notice: "Joined Event" }
        format.json { render :show, status: :created, location: @event_participation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_participations/1 or /event_participations/1.json
  def update
    respond_to do |format|
      if @event_participation.update(event_participation_params)
        format.html { redirect_to event_participation_url(@event_participation), notice: "Event participation was successfully updated." }
        format.json { render :show, status: :ok, location: @event_participation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_participations/1 or /event_participations/1.json
  def destroy
    @event_participation.destroy!
    Activity.create(name: "#{current_user.username} left #{@event.title} event", description: "event-id_#{@event.id}", user_id: current_user.id)

    respond_to do |format|
      format.html { redirect_to event_url(@event_participation.event), notice: "Successfully left event.." }     
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_participation
      @event_participation = EventParticipation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_participation_params
      params.require(:event_participation).permit(:user_id, :event_id, :badge_count)
    end
end
