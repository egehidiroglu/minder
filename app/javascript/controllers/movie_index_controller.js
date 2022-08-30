import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="movie-index"
export default class extends Controller {
  connect() {
    console.log("hello")
  }

  favorite(event) {
    console.log("fav")
    var icon_color = event.target.style.color
    console.log(icon_color)
    if (icon_color === "rgb(14, 205, 171)") {
      console.log(true)
      event.target.style.color = ""
    } else {
      event.target.style.color = "rgb(14, 205, 171)"
    }
  }
}
