import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-menu"
export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  hide() {
    this.menuTarget.classList.add("hidden")
  }

  // Close menu when clicking on links
  connect() {
    this.element.addEventListener("click", (event) => {
      if (event.target.closest("a")) {
        this.hide()
      }
    })
  }
}