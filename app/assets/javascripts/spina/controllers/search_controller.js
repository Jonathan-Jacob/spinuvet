import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["frame", "input"];
  }

  addParams() {
    if (this.frameTarget.src) {
      this.inputTarget.setAttribute(action, this.frameTarget.src);
    }
    console.log(this.frameTarget);
  }
}
