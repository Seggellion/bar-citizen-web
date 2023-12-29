class DiscordsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    # POST /discords
    def create
      @discord = Discord.new(discord_params)
      @discord.update(user_id: current_user.id, action_id: current_user.id, published:true)
      if @discord.save
        Activity.create(name: "New discord created", description: "discord-id_#{@discord.id}", user_id: @discord.user_id)
        redirect_to dashboard_path, notice: 'Discord was successfully created.'
      else
        redirect_to dashboard_path, notice: 'Discord not created'
      end
    end

    def update
      @discord = Discord.find(params[:id])
      respond_to do |format|
        if @discord.update(discord_params)
          format.html { redirect_to dashboard_path, notice: "Discord was successfully updated." }

        else
          format.html { redirect_to dashboard_path, notice: "Event was not successfully updated." }

        end
      end
    end

    def edit
      @discord = Discord.find(params[:id])
    end
  
  # DELETE /event_participations/1 or /event_participations/1.json
  def destroy
    @discord.destroy!
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: "Successfully Deleted discord." }     
      format.json { head :no_content }
    end
  end

    private
      # Only allow a list of trusted parameters through.
      def discord_params
        params.require(:discord).permit(:server_name, :region_id, :server_description, :city, :user_id, :server_url, :discord_type,:discordable_type, :discordable_id)

      end


    def authenticate_user!
      redirect_to login_path, alert: 'You must be logged in to perform this action.' if current_user.nil?
    end



  end
  