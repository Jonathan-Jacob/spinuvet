import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ['viewTemplate', 'content']
  }

  toggle(event) {
    console.log(event);
  }

}
