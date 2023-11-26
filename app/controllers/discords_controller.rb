class DiscordsController < ApplicationController
    # POST /discords
    def create
      @discord = Discord.new(discord_params)
      @discord.user_id = current_user.id
      if @discord.save
        redirect_to admin_discords_path, notice: 'Discord was successfully created.'
      else
        redirect_to admin_discords_path, notice: 'Discord not created'
      end
    end
  
    private
      # Only allow a list of trusted parameters through.
      def discord_params
        params.require(:discord).permit(:server_name, :region_id)
      end
  end
  