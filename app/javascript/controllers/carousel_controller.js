import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["carouselSlide"]
  currentIndex = 0
  interval = null

  connect() {
    this.initializeSlides();
    this.showSlide(this.currentIndex);
    this.startAutoSlide();
  }

  initializeSlides() {
    this.carouselSlideTargets.forEach((el, i) => {
      el.classList.add("hidden"); // Initially hide all slides
    });
  }

  startAutoSlide() {
    this.interval = setInterval(() => {
      this.next();
    }, 5000); // Change slide every 5 seconds
  }

  stopAutoSlide() {
    clearInterval(this.interval);
  }

  next() {
    this.stopAutoSlide();
    let nextIndex = (this.currentIndex + 1) % this.carouselSlideTargets.length;
    this.transitionSlides(nextIndex);
    this.startAutoSlide();
  }

  previous() {
    this.stopAutoSlide();
    let previousIndex = (this.currentIndex - 1 + this.carouselSlideTargets.length) % this.carouselSlideTargets.length;
    this.transitionSlides(previousIndex);
    this.startAutoSlide();
  }

  showSlide(index) {
    let newSlide = this.carouselSlideTargets[index];
    newSlide.classList.remove("hidden");
    newSlide.classList.add("active");
    this.currentIndex = index;
  }

  transitionSlides(newIndex) {
    if (newIndex === this.currentIndex) return;

    let oldSlide = this.carouselSlideTargets[this.currentIndex];
    let newSlide = this.carouselSlideTargets[newIndex];

    newSlide.classList.remove("hidden");
    setTimeout(() => {
      newSlide.classList.add("active");
      oldSlide.classList.add("out");
    }, 20); // Short delay to ensure proper stacking

    setTimeout(() => {
      oldSlide.classList.add("hidden");
      oldSlide.classList.remove("active", "out");
      this.currentIndex = newIndex;
    }, 500); // The same duration as the CSS transition
  }

  disconnect() {
    this.stopAutoSlide();
  }
}
