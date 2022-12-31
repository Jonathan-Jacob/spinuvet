import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["frame", "input"];
  }

  addParams() {
    console.log(this.frameTarget);
  }
}
