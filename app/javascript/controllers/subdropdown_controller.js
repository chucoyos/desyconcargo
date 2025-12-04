import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="subdropdown"
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
    this.arrowTarget?.classList.add("rotate-90")
  }

  hide() {
    this.menuTarget.classList.add("hidden")
    this.arrowTarget?.classList.remove("rotate-90")
  }

  // Hide subdropdown when mouse leaves the parent menu
  hideOnMouseLeave() {
    this.hide()
  }
}