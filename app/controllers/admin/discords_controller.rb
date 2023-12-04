# app/controllers/admin/posts_controller.rb

module Admin
  class DiscordsController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'
    def index
      @discords = Discord.where(trashed:nil)
      @users = User.all
    end


    def unpublished
      @discords = Discord.where(published:false)
    end

    def publish
      discord = Discord.find(params[:id])

      discord.update(published: true, action_id: @current_user.id)
  
      Activity.create(name: "New discord created", description: "discord-id_#{@discord.id}", user_id: discord.user_id)
      redirect_to admin_discords_path, notice: 'Discord was successfully published.'

    end
  
    def unpublish
      discord = Discord.find(params[:id])

      discord.update(published: nil, action_id: @current_user.id)
  
      Activity.create(name: "Discord unpublished", user_id: discord.user_id)
      redirect_to admin_discords_path, notice: 'Discord was successfully unpublished.'

    end

    def trash
      
      discord = Discord.find(params[:id])
      discord.update(trashed: true, action_id: @current_user.id)
      redirect_to admin_discords_path, notice: 'Discord was successfully trashed.'
      unless discord.user.user_type < 2
      author = User.find(discord.user_id)
      author.update(karma: author.karma - 200, fame: author.fame - 200)
      end
      # Redirect or render as needed
    end

    # POST /discords
    def create
      @discord = Discord.new(discord_params)

      @discord.update(published: true, action_id: @current_user.id)
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
        params.require(:discord).permit(:server_name, :region_id, :user_id, :server_url, :discordable_id,:discordable_type)
      end

    # ... other CRUD actions ...
  end
end
