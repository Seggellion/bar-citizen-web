# app/channels/event_chat_channel.rb

class EventChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from must be unique for each event, "event_chat_#{params[:event_id]}" is a common practice.
    stream_from "event_chat_#{params[:event_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # You would create a message related to an event here and broadcast it.

    message = EventMessage.create!(message: data['message'], user: current_user, event_id: params[:event_id])
    event = Event.find(params[:event_id])

    ActionCable.server.broadcast("event_chat_#{params[:event_id]}", { message: render_message(message, event) })

  end

  private

  def render_message(message, event)

    ApplicationController.renderer.render(partial: 'event_messages/message', locals: { message: message, event: event })
  end
end
