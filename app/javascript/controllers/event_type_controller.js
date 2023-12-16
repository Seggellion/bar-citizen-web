import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static values = { virtualRegionId: Number }
  static targets = ["select", "conditional", "region"]

  connect() {
    const newEvent = document.getElementById('newEvent');
  }

  toggleFields() {
    const eventType = this.selectTarget.value;
    this.conditionalTargets.forEach((el) => {
      if (eventType === 'irl') {
        el.style.display = null;
        this.setRequired(el, true);
        this.resetRegionId();
        newEvent.classList.add('bg-black');
        newEvent.classList.remove('bg-purple');
      } else {
        el.style.display = 'none';
        this.setRequired(el, false);
        this.setRegionToVirtual();
        newEvent.classList.remove('bg-black');
        newEvent.classList.add('bg-purple');
      }
    });
  }

  setRequired(element, isRequired) {
    const inputs = element.querySelectorAll('input, select, textarea');
    inputs.forEach(input => {
      input.required = isRequired;
    });
  }

  setRegionToVirtual() {
    const regionSelect = this.regionTarget;
    if (regionSelect) {
      regionSelect.value = this.virtualRegionIdValue;
    }
  }

  resetRegionId() {
    const regionSelect = this.regionTarget;
    if (regionSelect) {
      regionSelect.value = '';
    }
  }
}