class EventsController < ApplicationController
  before_action :set_event, only: %i[ show_virtual show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /events or /events.json
  def index
    @published_events = Event.where(published:true, event_type: 'irl').order(:start_datetime)
  end



  # GET /events/1 or /events/1.json
  def show
    @photo = Photo.new
    @current_event = Event.find_by_slug(params[:id])
    @photos = @current_event.photos.where(published:true)
    @posts = @current_event.region.post_category&.posts
    @current_event.increment!(:views_count)
    @event_managers = EventManager.where(event_id: @current_event.id)
    @messages = @current_event.event_messages
    @attendees = @current_event.attendees
    @current_discord = @current_event.discord

  end

  def virtual
    @published_events = Event.where(published:true, event_type: 'virtual')
  end

  def show_virtual
    @current_event = Event.find_by!(slug: params[:slug], event_type: 'virtual')
    @slug_event = Event.friendly.find(params[:slug])

    @photo = Photo.new
    @photos = @current_event.photos.where(published:true)
    @posts = @current_event.region.post_category&.posts
    @current_event.increment!(:views_count)
    @event_managers = EventManager.where(event_id: @current_event.id)
    @messages = @current_event.event_messages
    @attendees = @current_event.attendees

    # Handle the case where the event is not found or not virtual
  end

  # GET /events/new
  def new
    @event = Event.new
    @virtual_region_id = Region.find_by(name: "Virtual")&.id

  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    
    @event = Event.new(event_params)
    @event.creator_id = current_user.id # Set the creator_id to current_user's id


    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    
    respond_to do |format|
      if @event.update(event_params)

        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def invite
    event_slug = params[:event]
    @event = Event.find_by(slug: event_slug)
    
    if @event
      session[:event_redirect] = event_path(@event)
      # Store the information for the view
      @redirect_to_discord = true
    else
      redirect_to root_path, alert: 'Invalid invite link'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event

if params[:id]
  @event = Event.find_by_slug(params[:id])
else
  @event = Event.find_by_slug(params[:slug])
end

     
    end

    def check_event_manager_permissions
      unless current_user.is_manager(self) || current_user.admin?
        redirect_to root_path, alert: 'You do not have permission to perform this action.'
      end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :banner, :discord_id, :location_name, :city, :status, :event_type, :description, :twitter, :start_datetime, :end_datetime, :address, :region_id, :facebook_link, :creator_id,  images: [])
    end

    def authenticate_user!
      redirect_to root_path, alert: 'You must be signed in to access this page.' unless user_signed_in?
    end
end
