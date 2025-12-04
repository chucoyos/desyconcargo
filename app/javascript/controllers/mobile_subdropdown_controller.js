import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-subdropdown"
export default class extends Controller {
  static targets = ["configMenu", "configArrow"]

  toggleConfig() {
    const isHidden = this.configMenuTarget.classList.contains("hidden")

    if (isHidden) {
      this.showConfig()
    } else {
      this.hideConfig()
    }
  }

  showConfig() {
    this.configMenuTarget.classList.remove("hidden")
    this.configArrowTarget?.classList.add("rotate-180")
  }

  hideConfig() {
    this.configMenuTarget.classList.add("hidden")
    this.configArrowTarget?.classList.remove("rotate-180")
  }
}