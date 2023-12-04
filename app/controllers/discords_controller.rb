class DiscordsController < ApplicationController
    # POST /discords
    def create
      @discord = Discord.new(discord_params)
      @discord.update(action_id: @current_user.id)
      if @discord.save
        Activity.create(name: "New Discord created", description: "discord-id_#{@discord.id}", user_id: @discord.user_id)
        redirect_to admin_discords_path, notice: 'Discord was successfully created.'
      else
        redirect_to admin_discords_path, notice: 'Discord not created'
      end
    end
  
    private
      # Only allow a list of trusted parameters through.
      def discord_params
        params.require(:discord).permit(:server_name, :region_id, :user_id, :server_url, :discord_type,:discordable_type, :discordable_id)

      end
  end
  