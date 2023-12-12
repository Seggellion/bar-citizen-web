# app/controllers/admin/blocks_controller.rb
module Admin
    class BlocksController < ApplicationController
        before_action :authenticate_admin!
        layout 'admin'
  
      def create
        @block = Block.new(block_params)
        
        if @block.save
            redirect_to admin_settings_path, notice: 'Event was successfully trashed.'
        else
            redirect_to admin_settings_path, notice: 'Event was successfully trashed.'
        end
      end

      def update
        @block = Block.find(params[:id])

        respond_to do |format|
          if @block.update(block_params)
            format.html { redirect_to admin_settings_path, notice: 'Block was successfully updated.' }
            format.json { render :show, status: :ok, location: @block }
          else
      
            format.html { redirect_to admin_settings_path, alert: 'Failed to update block.' }
            format.json { render json: @block.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @block = Block.find(params[:id])
        @block.destroy
        redirect_to request.referer || admin_settings_path, notice: 'Block was successfully deleted.'
      end
      

      private
  
      def block_params
        params.require(:block).permit(:title, :section_id, :description, :image, :link_url, translations_attributes: [:id, :language, :title, :description, :_destroy])

      end
    end
  end
  