import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-dropdown"
export default class extends Controller {
  static targets = ["catalogMenu", "catalogArrow"]

  toggleCatalog() {
    const isHidden = this.catalogMenuTarget.classList.contains("hidden")

    if (isHidden) {
      this.showCatalog()
    } else {
      this.hideCatalog()
    }
  }

  showCatalog() {
    this.catalogMenuTarget.classList.remove("hidden")
    this.catalogArrowTarget?.classList.add("rotate-180")
  }

  hideCatalog() {
    this.catalogMenuTarget.classList.add("hidden")
    this.catalogArrowTarget?.classList.remove("rotate-180")
  }
}