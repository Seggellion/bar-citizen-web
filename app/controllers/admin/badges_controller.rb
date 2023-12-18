# app/controllers/admin/blocks_controller.rb
module Admin
    class BadgesController < ApplicationController

        before_action :authenticate_admin!
        layout 'admin'
        def index
          @badges = Badge.all
         # @badges = Badge.where(trashed:nil)
        end

        def edit
          @badge = Badge.find(params[:id])
        end
  
        def trash
          
          message = Badge.find(params[:id])
         # message.update(trashed: true, action_id: @current_user.id)
      
          author = User.find(message.user_id)
  
          redirect_to admin_badges_path, notice: 'Badge was successfully trashed.'
          # Redirect or render as needed
        end

    # POST /badges
    def create
      
        @badge = Badge.new(badge_params)
        @badge.user_id = @current_user.id
  
        if @badge.save
          Activity.create(name: "New badge created", description: "badge-id_#{@badge.id}", user_id: @badge.user_id)
          redirect_to admin_badges_path, notice: 'Badge was successfully created.'
        else
          redirect_to admin_badges_path, notice: 'Badge not created'
        end
      end

      def update

        @badge = Badge.find(params[:id])
        
        respond_to do |format|
          if @badge.update(badge_params)
            format.html { redirect_to admin_badge_path(@badge), notice: "User was successfully updated." }
            format.json { render :show, status: :ok, location: @badge }
          else
            format.html { redirect_to admin_badges_path, status: :unprocessable_entity }
            format.json { render json: @badge.errors, status: :unprocessable_entity }
          end
        end
      end
    
      private
        # Only allow a list of trusted parameters through.
        def badge_params
          params.require(:badge).permit(:name, :description, :icon)
        end



    end
end