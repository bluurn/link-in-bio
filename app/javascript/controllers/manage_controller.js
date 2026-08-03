import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const y = sessionStorage.getItem("manage_scroll_y")
    if (y !== null) {
      if (window.innerWidth < 1024) {
        requestAnimationFrame(() => window.scrollTo(0, parseInt(y, 10)))
      }
      sessionStorage.removeItem("manage_scroll_y")
    }
  }

  saveScroll() {
    if (window.innerWidth < 1024) {
      sessionStorage.setItem("manage_scroll_y", window.scrollY)
    }
  }
}
