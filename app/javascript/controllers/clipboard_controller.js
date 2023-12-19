import { Controller } from "@hotwired/stimulus"
// app/javascript/controllers/clipboard_controller.js


export default class extends Controller {
  static targets = ["source"];

  copy(event) {
    event.preventDefault(); // Prevent the link navigation

    const link = this.sourceTarget.getAttribute('href');
    navigator.clipboard.writeText(link)
      .then(() => {
        // Show a notification to the user
        this.showNotification('Link copied to clipboard');
      })
      .catch(err => {
        console.error('Error in copying text: ', err);
        // Optionally, show a failure notification
        this.showNotification('Failed to copy link', true);
      });
  }

  showNotification(message, isError = false) {
    // Create and display a notification element
    let notification = document.createElement('div');
    notification.textContent = message;
    notification.className = 'clipboard-notification';

    // Add error styling if needed
    if (isError) {
      notification.classList.add('error');
    }

    document.body.appendChild(notification);

    // Remove the notification after a delay
    setTimeout(() => {
      document.body.removeChild(notification);
    }, 3000);
  }
}
