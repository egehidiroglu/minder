import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="movie-index"
export default class extends Controller {
  connect() {
    console.log("movie")
  }

  favorite(event) {
    if (event.target.classList.contains('btn-heart-checked')) {
      event.target.classList.replace('btn-heart-checked', 'btn-heart-unchecked')
    } else {
      event.target.classList.replace('btn-heart-unchecked', 'btn-heart-checked')
    }
  }
}
