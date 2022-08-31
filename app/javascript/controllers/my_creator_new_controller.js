import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="my-creator-new"
export default class extends Controller {
  static targets = ["creator"]

  connect() {
    console.log("new")
  }

  save(event) {
    event.preventDefault()
    const token  = document.getElementsByName("csrf-token")[0].content
    console.log(token)
    console.log("save")
    console.log(this.creatorTarget.id)
    const json_data = JSON.stringify({ creator_id: this.creatorTarget.id })
    fetch("/artist_setup_ajax", {
      method: "POST",
      mode: 'cors',
      body: json_data,
      headers: { "Content-Type": "application/json", "Accept": "application/json", 'X-CSRF-TOKEN': token }
    }).then(response=>response.json())
    .then(data => this.creatorTarget.remove())
    .catch(error => console.log(error))
  }
}
