import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source"]

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.getAttribute('href'))
      .then(() => {
        // You can show some notification to the user here
        console.log('Event link copied to clipboard!');
      })
      .catch(err => {
        console.error('Error in copying text: ', err);
      });
  }
}
