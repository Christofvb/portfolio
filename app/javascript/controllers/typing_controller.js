import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  static values = { text: String }

  connect() {
    this.index = 0
    this.type()
  }

  type() {
    if (this.index < this.textValue.length) {
      this.outputTarget.textContent += this.textValue.charAt(this.index)
      this.index++
      setTimeout(() => this.type(), 80)
    }
  }
}
