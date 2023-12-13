// app/javascript/controllers/chat_controller.js

import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { eventId: Number }

  connect() {
    this.setupSubscription();
  }

  setupSubscription() {
    this.subscription = consumer.subscriptions.create(
      { channel: "EventChatChannel", event_id: this.eventIdValue },
      {
        received(data) {
          const messagesContainer = document.getElementById('messages');
          if (messagesContainer) {
            messagesContainer.insertAdjacentHTML('beforeend', data.message);
            // Scroll to the bottom of the container
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
          } else {
            console.error('Messages container not found');
          }
        }
        
      }
    );
  }

  send(event) {
    if(event.keyCode === 13) { // Enter key
      event.preventDefault();
      this.subscription.perform('speak', { message: event.target.value });
      event.target.value = '';
    }
  }
}
