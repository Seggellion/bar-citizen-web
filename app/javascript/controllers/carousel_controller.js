import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["carouselSlide"]

  currentIndex = 0

  connect() {
    if (this.carouselSlideTargets.length > 0) {
      this.showSlide(this.currentIndex)
    }
  }

  next() {
    console.log('next');

    this.showSlide((this.currentIndex + 1) % this.carouselSlideTargets.length)
  }

  previous() {
    console.log('previous');
    this.showSlide((this.currentIndex - 1 + this.carouselSlideTargets.length) % this.carouselSlideTargets.length)
  }

  showSlide(index) {
    this.currentIndex = index
    this.carouselSlideTargets.forEach((el, i) => {
      el.classList.toggle("hidden", i !== index)
    })
  }
}
