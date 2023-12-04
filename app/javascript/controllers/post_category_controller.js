import { Controller } from "@hotwired/stimulus"


export default class extends Controller {

    static targets = ["regionSelector"]

connect(){
    console.log('output');
}

    toggleRegionSelector(event) {
      const selectedType = event.target.value;
      if (selectedType === 'Region') {
        this.regionSelectorTarget.style.display = '';
      } else {
        this.regionSelectorTarget.style.display = 'none';
      }
    }

}