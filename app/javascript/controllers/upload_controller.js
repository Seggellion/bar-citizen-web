import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "imageInput", "container" ]

  previewImage() {
    const input = this.imageInputTarget
    const container = this.containerTarget
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        container.style.backgroundImage = `url(${e.target.result})`;
        container.style.backgroundSize = 'cover';
        // Optional: hide other elements inside the container
        container.querySelectorAll('.child-elements').forEach(el => el.style.display = 'none');
      }
      reader.readAsDataURL(input.files[0]);
    }
}
}
