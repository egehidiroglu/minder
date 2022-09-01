import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="my-favorites-index"
export default class extends Controller {
  static targets = ["favorite"]
  connect() {
    console.log("my favorites")
  }

  delete() {
    console.log(true)
    console.log(this.favoriteTarget)
    this.favoriteTarget.remove()
  }
}
