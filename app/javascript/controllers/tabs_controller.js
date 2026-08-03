import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "tab"]
  static values = { active: { type: Number, default: 0 } }

  connect() {
    this.mq = window.matchMedia("(min-width: 1024px)")
    this.mq.addEventListener("change", () => this.sync())
    if (!this.mq.matches) {
      const params = new URLSearchParams(window.location.search)
      if (params.get("tab") === "1") {
        this.activeValue = 1
        params.delete("tab")
        const qs = params.toString()
        history.replaceState(null, "", window.location.pathname + (qs ? "?" + qs : ""))
      }
    }
    this.sync()
  }

  disconnect() {
    this.mq.removeEventListener("change", () => this.sync())
  }

  show(event) {
    this.activeValue = this.tabTargets.indexOf(event.currentTarget)
  }

  activeValueChanged() { this.sync() }

  sync() {
    if (!this.mq) return
    const desktop = this.mq.matches
    this.panelTargets.forEach((panel, i) => {
      panel.style.display = desktop || i === this.activeValue ? "" : "none"
    })
    this.tabTargets.forEach((tab, i) => {
      const active = i === this.activeValue
      tab.classList.toggle("bg-white", active)
      tab.classList.toggle("shadow-sm", active)
      tab.classList.toggle("text-gray-900", active)
      tab.classList.toggle("text-gray-500", !active)
    })
  }
}
