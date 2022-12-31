import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["frame", "input"];
  }

  addParams(event) {
    event.preventDefault();
    if (this.frameTarget.src) {
      this.inputTarget.value = this.frameTarget.src;
    }
    this.inputTarget.submit();
  }
}
