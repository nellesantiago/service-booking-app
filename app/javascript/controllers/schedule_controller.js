import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
    static values = {
      clicked: {type: String, default: "0"}
    }
  change(event) {
    let date = event.target.value
    let button = document.querySelector('input[type="submit"]')
    button.setAttribute("disabled", true)

    get(`/orders/schedules?date=${date}`, {
      responseKind: "turbo-stream"
    })
  }

  radio(event) {
    this.clickedValue = event.target.value

    let button = document.querySelector('input[type="submit"]')
    if (this.clickedValue > 0) {
      button.removeAttribute("disabled")
    }
  }
}
