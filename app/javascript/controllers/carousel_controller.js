import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["carouselSlide"]
  currentIndex = 0
  interval = null

  connect() {
    this.showSlide(this.currentIndex)
    this.startAutoSlide();
  }

  startAutoSlide() {
    this.interval = setInterval(() => {
      this.next()
    }, 5000); // Change slide every 5 seconds
  }

  stopAutoSlide() {
    clearInterval(this.interval);
  }

  next() {
    this.stopAutoSlide();
    this.showSlide((this.currentIndex + 1) % this.carouselSlideTargets.length)
    this.startAutoSlide();
  }

  previous() {
    this.stopAutoSlide();
    this.showSlide((this.currentIndex - 1 + this.carouselSlideTargets.length) % this.carouselSlideTargets.length)
    this.startAutoSlide();
  }

  showSlide(index) {
    this.currentIndex = index
    this.carouselSlideTargets.forEach((el, i) => {
      el.classList.toggle("hidden", i !== this.currentIndex)
      el.classList.toggle("slide-in", i === this.currentIndex)
    })
  }

  disconnect() {
    this.stopAutoSlide();
  }
}
