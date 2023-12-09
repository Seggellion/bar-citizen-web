import { Controller } from "@hotwired/stimulus"


export default class extends Controller {

    static targets = ["content"]

    connect() {
        console.log('connected')
      }


      toggle(event) {
        console.log('toggled', event);
        const content = event.currentTarget.nextElementSibling;
        content.classList.toggle('hidden');
      }

}