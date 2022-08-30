import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="my-creator-index"
export default class extends Controller {
  static targets = ["creator"]
  connect() {
    console.log("my creators")
  }

  delete() {
    this.creatorTarget.remove()
  }
}
