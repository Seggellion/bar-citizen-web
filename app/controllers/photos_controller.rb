class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:create, :new]

  # GET /photos or /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1 or /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos or /photos.json
  def create
    
    @event = Event.find(params[:event_id])
    
    #@photo = @event.photos.build(photo_params.except(:image).merge(user: current_user))
    @photo = @event.photos.build(photo_params.merge(user: current_user))

    respond_to do |format|
      if @photo.save
        @photo.image.attach(photo_params[:image]) if photo_params[:image].present?
        format.html { redirect_to event_path(@event), notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { redirect_to event_path(@event), status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
      format.all { head :no_content }  # Handles other formats
    end
  end
  

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to photo_url(@photo), notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy!

    respond_to do |format|
      format.html { redirect_to photos_url, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def authenticate_user!
      redirect_to login_path, alert: 'You must be logged in to perform this action.' if current_user.nil?
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      #params.require(:attachment).permit(:image, :published, :category, :region)
      params.require(:photo).permit(:image, :published, :category, :region)

      #params.require(:photo).permit(:event_id, :user_id, :image_url, :upvotes, :downvotes, :favorites_count, :image, :published, :category, :region, tag_ids: [])
    end
end
