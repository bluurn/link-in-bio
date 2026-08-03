import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["body", "toggle"]

  connect() {
    if (this.bodyTarget.scrollHeight <= this.bodyTarget.clientHeight + 2) {
      this.toggleTarget.hidden = true
    }
  }

  expand() {
    this.bodyTarget.classList.remove("line-clamp-4")
    this.toggleTarget.hidden = true
  }
}
