# app/controllers/admin/messages_controller.rb

module Admin
    class MessagesController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
      def index
        @messages = Message.where(receiver_id:current_user.id)
       # @messages = Message.where(trashed:nil)
      end

      def trash
        
        message = Message.find(params[:id])
       # message.update(trashed: true, action_id: @current_user.id)
    
        author = User.find(message.user_id)

        author.update(karma: author.karma - 200, fame: author.fame - 200)
        redirect_to admin_messages_path, notice: 'Message was successfully trashed.'
        # Redirect or render as needed
      end
  
      # ... other CRUD actions ...
    end
  end
  