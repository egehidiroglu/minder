import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="my-creator-index"
export default class extends Controller {
  connect() {
    console.log("my creators")
  }

  delete(event) {
    console.log(event)
  }
}
