import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["selectedContainer"];
  }

  connect() {
    console.log('pi controller connected');
  }

  add(e) {
    console.log(e.currentTarget);
    this.selectedContainerTarget.appendChild(e.currentTarget.parentNode.cloneNode());
  }

}
