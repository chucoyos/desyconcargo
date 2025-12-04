import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "arrow"]

  toggle() {
    const isHidden = this.menuTarget.classList.contains("hidden")
    
    if (isHidden) {
      this.show()
    } else {
      this.hide()
    }
  }

  show() {
    this.menuTarget.classList.remove("hidden")
    this.arrowTarget?.classList.add("rotate-180")
  }

  hide() {
    this.menuTarget.classList.add("hidden")
    this.arrowTarget?.classList.remove("rotate-180")
  }

  // Hide dropdown when clicking outside
  connect() {
    this.boundHideOnClickOutside = this.hideOnClickOutside.bind(this)
    document.addEventListener("click", this.boundHideOnClickOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.boundHideOnClickOutside)
  }

  hideOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.hide()
    }
  }
}