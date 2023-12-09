
import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const eventElement = document.getElementById('event_chat');
  const event_id = eventElement.getAttribute('data-event-id');

  consumer.subscriptions.create({ channel: "EventChatChannel", event_id: event_id }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log("Connected to the channel.");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
      console.log("Disconnected to the channel.");
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log('received');
   
      const messages = document.getElementById('messages');
      messages.innerHTML += data.message;
    }
  });
});