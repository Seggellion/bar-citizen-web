import { Controller } from "@hotwired/stimulus"


export default class extends Controller {

  static targets = ["type", "selector"]

  connect() {
    this.updateSelector()
    console.log('test');
  }

  updateSelector() {
    const selectedType = this.typeTarget.value;
    const url = selectedType === 'Region' ? '/api/regions' : '/api/events'; // Updated URLs

    fetch(url)
      .then(response => response.json())
      .then(data => this.populateOptions(data, selectedType));
  }

  populateOptions(data, type) {
    let optionsHtml = data.map(item => {
      let displayText = type === 'Region' ? item.name : item.title; // Adjust based on type
      return `<option value="${item.id}">${displayText}</option>`;
    }).join('');
  
    this.selectorTarget.innerHTML = `<select name="discord[discordable_id]" class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600">${optionsHtml}</select>`;
  }
  

  
}



