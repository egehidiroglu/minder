import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-index"
export default class extends Controller {
  connect() {
    console.log("books")
  }

  favorite(event) {
    console.log("fav")
    var icon_color = event.target.style.color
    console.log(icon_color)
    if (icon_color === "rgb(14, 205, 171)") {
      console.log("green")
      event.target.style.color = ""
    } else {
      console.log("black")
      event.target.style.color = "rgb(14, 205, 171)"
    }
  }
}
