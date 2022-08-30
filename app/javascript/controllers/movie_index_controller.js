import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="movie-index"
export default class extends Controller {
  connect() {
    console.log("hello")
  }

  favorite(event) {
    console.log("fav")
  }

  unfavorite(event) {
    console.log("unfav")
  }
}
