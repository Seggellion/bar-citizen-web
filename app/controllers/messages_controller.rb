# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
    def new
      @message = Message.new
    end
  
    def create
      @message = Message.new(message_params)
      @message.sender = current_user # Assuming `current_user` is the logged-in user
      @message.receiver = User.first
      # You'll need to set the receiver based on your app logic
      
      if @message.save
        # Handle successful save
        Activity.create(name: "Bug submitted", description: "message-id_#{@message.id}", user_id: current_user.id)
        flash[:success] = "Message sent successfully."
      else
        # Handle failure
        flash[:error] = "There was a problem sending the message."
      end
    
      # Redirect back to the same page, or to some fallback location (e.g., root_path) if the HTTP_REFERER is not present
      redirect_back(fallback_location: root_path)
    end
  
    private
  
    def message_params
      params.require(:message).permit(:subject, :description, :image)
    end
  end
  