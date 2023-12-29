import { Controller } from "@hotwired/stimulus"


export default class extends Controller {

        submitForm() {


          if (confirm('Are you sure you want to change the user type?')) {
            this.element.submit();
          }

        }

}