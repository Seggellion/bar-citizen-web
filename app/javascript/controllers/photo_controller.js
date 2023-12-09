import { Controller } from "@hotwired/stimulus"


export default class extends Controller {


    connect() {

        const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        fetch(`/photos/${this.data.get("id")}/view`, {
          method: 'POST',
          headers: {
            'X-CSRF-Token': token,
            'Content-Type': 'application/json',
          },
          credentials: 'include',
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => console.log(data))
        .catch(error => console.error('There has been a problem with your fetch operation:', error));
      }

}