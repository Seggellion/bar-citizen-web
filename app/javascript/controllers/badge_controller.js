import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = { name: String }
    static targets = ["tooltip"]
  
    showName() {
    const badgeName = event.currentTarget.getAttribute('data-badge-name-value');

      this.tooltipTarget.textContent = badgeName;
      this.tooltipTarget.classList.add("show-tooltip");
    }
  
    hideName() {
      this.tooltipTarget.classList.remove("show-tooltip");
    }
  }