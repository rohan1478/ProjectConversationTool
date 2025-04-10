import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove()
    }, 4000)
    console.log("Flash controller connected!")
  }  
}
