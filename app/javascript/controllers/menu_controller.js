import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "icon"]

  toggle() {
    this.menuTarget.classList.toggle("hidden")
    this.iconTarget.classList.toggle("fa-bars")
    this.iconTarget.classList.toggle("fa-xmark")
  }

  close() {
    this.menuTarget.classList.add("hidden")
    this.iconTarget.classList.add("fa-bars")
    this.iconTarget.classList.remove("fa-xmark")
  }
}
