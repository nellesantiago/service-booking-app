import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  change(event) {
    let date = event.target.value

    get(`/orders/schedules?date=${date}`, {
      responseKind: "turbo-stream"
    })
  }
}
