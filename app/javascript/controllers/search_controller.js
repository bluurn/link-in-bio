import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "clear"]

  connect() {
    this.timeout = null
    this.syncClear()
  }

  debounce() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => this.element.requestSubmit(), 300)
    this.syncClear()
  }

  clear() {
    this.inputTarget.value = ""
    this.inputTarget.focus()
    this.syncClear()
    this.element.requestSubmit()
  }

  navigate(event) {
    event.preventDefault()
    const url = new URL(event.currentTarget.href)
    url.searchParams.set("q", this.inputTarget.value)
    Turbo.visit(url.toString())
  }

  syncClear() {
    if (this.hasClearTarget) {
      this.clearTarget.hidden = this.inputTarget.value === ""
    }
  }
}
